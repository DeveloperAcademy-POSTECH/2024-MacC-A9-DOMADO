//
//  LoggerHandler.swift
//  Core
//
//  Created by 이종선 on 9/28/24.
//

/// 로그 이벤트를 처리하는 핸들러의 인터페이스를 정의하는 프로토콜입니다.
///
/// 이 프로토콜은 로그 이벤트를 다양한 방식으로 처리할 수 있도록 설계되었습니다.
/// 예를 들어, 로그를 파일에 기록하거나 콘솔에 출력하는 등의 작업을 수행할 수 있습니다.
///
/// ## 장점:
/// - 유연한 로그 처리: 다양한 핸들러를 구현하여 로그를 여러 방식으로 처리할 수 있습니다.
/// - 확장성: 새로운 로그 처리 방식이 필요할 때마다 쉽게 핸들러를 추가할 수 있습니다.
/// - 모듈화: 로깅 시스템의 책임을 핸들러에게 분리하여, 코드의 유지보수성을 높입니다.
///
/// ## 사용 예시:
///
/// public class FileLoggerHandler: LoggerHandler {
///     /// 로그를 기록할 파일의 URL입니다.
///     private let fileURL: URL
///
///     /// 파일 접근을 동기화하기 위한 락입니다.
///     private let fileLock = NSLock()
///
///     /// FileLoggerHandler의 이니셜라이저입니다.
///     ///
///     /// - Parameter fileName: 로그를 기록할 파일의 이름 (기본값: "app.log")
///     public init(fileName: String = "app.log") {
///         let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
///         fileURL = paths[0].appendingPathComponent(fileName)
///     }
///
///     /// 로그 이벤트를 파일에 기록합니다.
///     ///
///     /// - Parameter logEvent: 처리할 로그 이벤트
///     public func handle(logEvent: LogEvent) {
///         // 특정 OSLogType 이상만 기록 (예: info 이상)
///         guard logEvent.type != .debug else { return }
///
///         let logEntry: String
///         switch logEvent.type {
///         case .debug:
///             logEntry = "[DEBUG] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         case .info:
///             logEntry = "[INFO] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         case .default:
///             logEntry = "[WARNING] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         case .error:
///             logEntry = "[ERROR] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         case .fault:
///             logEntry = "[CRITICAL] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         @unknown default:
///             logEntry = "[GENERAL] [\(logEvent.category.name.uppercased())] \(logEvent.message)\n"
///         }
///
///         // 파일 쓰기 동기화
///         fileLock.lock()
///         defer { fileLock.unlock() }
///
///         do {
///             if FileManager.default.fileExists(atPath: fileURL.path) {
///                 if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
///                     defer {
///                         fileHandle.closeFile()
///                     }
///                     fileHandle.seekToEndOfFile()
///                     if let data = logEntry.data(using: .utf8) {
///                         fileHandle.write(data)
///                     }
///                 }
///             } else {
///                 try logEntry.write(to: fileURL, atomically: true, encoding: .utf8)
///             }
///         } catch {
///             // 오류 처리 (예: 콘솔에 출력)
///             print("Failed to write log: \(error)")
///         }
///     }
/// }
public protocol LoggerHandler: Sendable {
    /// 로그 이벤트를 처리합니다.
    ///
    /// - Parameter logEvent: 처리할 로그 이벤트
    func handle(logEvent: LogEvent)
}

