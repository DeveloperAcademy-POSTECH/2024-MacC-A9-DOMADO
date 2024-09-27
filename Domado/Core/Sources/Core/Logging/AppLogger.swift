//
//  AppLogger.swift
//  Core
//
//  Created by 이종선 on 9/22/24.
//

/// 애플리케이션 전체에서 사용되는 로깅 시스템의 인터페이스를 정의합니다.
///
/// 이 프로토콜은 애플리케이션의 다양한 부분에서 일관된 로깅 메커니즘을 제공하기 위해 사용됩니다.
/// `AppLogger`를 구현하는 클래스는 메시지 로깅, 로그 레벨 설정, 그리고 로그 카테고리 지정 기능을 제공해야 합니다.
///
/// ## 예시:
///
/// ```swift
/// class DefaultLogger: AppLogger {
///     func log(_ message: String, level: LogLevel, category: String) {
///         print("[\(level.rawValue.uppercased())][\(category)] \(message)")
///     }
///
///     func critical(_ message: String, category: String) {
///         print("[CRITICAL][\(category)] \(message)")
///         // 추가적인 처리 (예: 개발자에게 알림 전송)
///     }
/// }
///
/// let logger = DefaultLogger()
/// logger.log("사용자 로그인 성공", level: .info, category: "Authentication")
/// logger.critical("데이터베이스 연결 실패", category: "Database")
/// ```
///
/// 이 예시에서 `DefaultLogger`는 `AppLogger` 프로토콜을 구현하여 기본적인 콘솔 로깅을 제공합니다.
public protocol AppLogger {
    /// 지정된 레벨과 카테고리로 메시지를 로깅합니다.
    ///
    /// - Parameters:
    ///   - message: 로그에 기록할 메시지
    ///   - level: 로그의 중요도 수준
    ///   - category: 로그의 카테고리 (예: "Network", "Database", "UI" 등)
    func log(_ message: String, level: LogLevel, category: String)
    
    /// 크리티컬한 오류 메시지를 로깅합니다.
    ///
    /// 이 메소드는 즉각적인 주의가 필요한 심각한 문제를 로깅하는 데 사용됩니다.
    /// 일반적으로 추가적인 처리 (예: 개발자에게 알림 전송)를 포함할 수 있습니다.
    ///
    /// - Parameters:
    ///   - message: 크리티컬한 오류 메시지
    ///   - category: 오류가 발생한 카테고리
    func critical(_ message: String, category: String)
}
