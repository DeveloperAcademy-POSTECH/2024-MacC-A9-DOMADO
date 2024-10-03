//
//  CoreLogger.swift
//  Core
//
//  Created by 이종선 on 9/29/24.
//

import Foundation
import OSLog

/// 애플리케이션 전반에서 로그를 기록하고 관리하는 중앙 로깅 시스템입니다.
///
/// `CoreLogger`는 싱글톤 패턴을 사용하여 구현되었으며, 다양한 로그 레벨과 카테고리를 지원합니다.
/// 또한 다중 로그 핸들러를 지원하고 스레드 안전한 로그 기록을 보장합니다.
///
/// - Note: 이 클래스는 `@unchecked Sendable`로 표시되어 있습니다. 이는 컴파일러에게
///   이 타입이 `Sendable` 프로토콜을 준수한다고 알려주지만, 실제 검사는 개발자의 책임입니다.
///   `CoreLogger`는 내부적으로 커스텀 직렬 큐(`loggingQueue`)를 사용하여 모든 로깅 작업을
///   동기화함으로써 스레드 안전성을 보장합니다. 따라서 여러 스레드에서 동시에 접근하더라도
///   안전하게 동작합니다.
///
/// 예제:
/// ```swift
/// let logger = CoreLogger.shared
/// logger.info("애플리케이션이 시작되었습니다.")
///
/// // 사용자 정의 카테고리로 로그 기록
/// logger.error("네트워크 연결 실패", category: .network)
///
/// // 사용자 정의 로그 핸들러 추가
/// class MyCustomHandler: LoggerHandler {
///     func handle(logEvent: LogEvent) {
///         // 사용자 정의 로그 처리 로직
///     }
/// }
/// logger.addHandler(MyCustomHandler())
///
/// // 멀티스레딩 환경에서의 안전한 사용
/// DispatchQueue.global().async {
///     logger.debug("백그라운드 작업 시작")
/// }
/// DispatchQueue.main.async {
///     logger.info("UI 업데이트")
/// }
/// ```
public class CoreLogger: Logger, @unchecked Sendable {
    // MARK: - Singleton Instance
    
    /// CoreLogger의 싱글톤 인스턴스입니다.
    public static let shared = CoreLogger()
    
    // MARK: - Private Properties
    
    /// 등록된 로그 핸들러들을 저장하는 배열입니다.
    private(set) var handlers: [LoggerHandler] = []
    
    /// 로그 작업을 직렬화할 디스패치 큐입니다.
    private let loggingQueue: DispatchQueue
    
    /// OSLog 인스턴스
    private let osLog: OSLog
    
    // MARK: - Initializer
    
    /// CoreLogger의 프라이빗 이니셜라이저입니다.
    private init() {
        self.loggingQueue = DispatchQueue(label: "com.domado.CoreLoggerQueue")
        self.osLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.domado", category: "CoreLogger")
    }
    
    // MARK: - Public Methods
    
    /// 새로운 로그 핸들러를 추가합니다.
    ///
    /// - Parameter handler: 추가할 `LoggerHandler` 인스턴스
    public func addHandler(_ handler: LoggerHandler) {
        loggingQueue.async { [weak self] in
            self?.handlers.append(handler)
        }
    }
    
    /// 디버그 레벨의 로그를 기록합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리 (기본값: .general)
    public func debug(_ message: String, category: LogCategory = .general) {
        log(message, type: .debug, category: category)
    }
    
    /// 정보 레벨의 로그를 기록합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리 (기본값: .general)
    ///
    /// 예제:
    /// ```swift
    /// CoreLogger.shared.info("사용자 로그인 성공", category: .auth)
    /// ```
    public func info(_ message: String, category: LogCategory = .general) {
        log(message, type: .info, category: category)
    }
    
    /// 경고 레벨의 로그를 기록합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리 (기본값: .general)
    public func warning(_ message: String, category: LogCategory = .general) {
        log(message, type: .default, category: category)
    }
    
    /// 에러 레벨의 로그를 기록합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리 (기본값: .general)
    public func error(_ message: String, category: LogCategory = .general) {
        log(message, type: .error, category: category)
    }
    
    /// 크리티컬 레벨의 로그를 기록합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리 (기본값: .general)
    public func critical(_ message: String, category: LogCategory = .general) {
        log(message, type: .fault, category: category)
    }
    
    /// 애플리케이션 종료 시, 모든 로그 작업이 완료되도록 보장하는 메서드입니다.
    ///
    /// 이 메서드는 로그 작업이 모두 완료될 때까지 동기적으로 대기합니다.
    public func flush() {
        loggingQueue.sync {}
    }
    
    // MARK: - Private Methods
    
    /// 로그 메시지를 처리하는 내부 메서드입니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - type: 로그의 레벨을 나타내는 `OSLogType`
    ///   - category: 로그의 카테고리
    private func log(_ message: String, type: OSLogType, category: LogCategory) {
        loggingQueue.async { [weak self] in
            guard let self = self else { return }
            let logEvent = LogEvent(message: message, type: type, category: category)
            
            // 등록된 모든 핸들러에게 로그 이벤트 전달
            for handler in self.handlers {
                handler.handle(logEvent: logEvent)
            }
        
            // OSLog에 로그 기록
            os_log("%{public}@", log: self.osLog, type: type, message)
            
            // 디버그 모드에서 콘솔 출력
            #if DEBUG
            print("[\(category.name.uppercased())] [\(type)] \(message)")
            #endif
        }
    }
}


extension CoreLogger {
    
    /// Test시 사용되며 추가된 모든 핸들러를 제거하는 메서드입니다.
    ///
    /// internal 수준의 접근자를 통해 테스트 모듈에서만 사용이 가능하도록 합니다. 
    func removeHandler() {
        loggingQueue.async { [weak self] in
            self?.handlers.removeAll()
        }
    }
}
