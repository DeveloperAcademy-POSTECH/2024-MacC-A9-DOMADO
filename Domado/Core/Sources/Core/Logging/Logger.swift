//
//  Logger.swift
//  Core
//
//  Created by 이종선 on 9/22/24.
//

/// 애플리케이션 전체에서 사용되는 로깅 시스템의 인터페이스를 정의합니다.
///
/// 이 프로토콜은 다양한 로그 레벨과 카테고리를 지원하여 효과적인 로깅과 디버깅을 가능하게 합니다.
/// `Logger`를 구현하는 클래스는 각 로그 레벨에 맞는 적절한 로깅 메커니즘을 제공해야 합니다.
///
/// - Note: `LogCategory`는 별도로 정의되어야 하는 타입으로, 로그의 출처나 관련 모듈을 나타냅니다.
///
/// ## 예시:
///
/// ```swift
/// class ConsoleLogger: Logger {
///     func debug(_ message: String, category: LogCategory) {
///         print("[DEBUG][\(category)] \(message)")
///     }
///
///     func info(_ message: String, category: LogCategory) {
///         print("[INFO][\(category)] \(message)")
///     }
///
///     func warning(_ message: String, category: LogCategory) {
///         print("[WARNING][\(category)] \(message)")
///     }
///
///     func error(_ message: String, category: LogCategory) {
///         print("[ERROR][\(category)] \(message)")
///     }
///
///     func critical(_ message: String, category: LogCategory) {
///         print("[CRITICAL][\(category)] \(message)")
///         // 추가적인 알림 로직 구현 가능
///     }
/// }
///
/// let logger = ConsoleLogger()
/// logger.info("사용자 로그인 성공", category: .authentication)
/// logger.error("데이터베이스 쿼리 실패", category: .database)
/// ```
public protocol Logger {
    /// 디버그 정보를 로깅합니다. 주로 개발 중 상세한 정보를 기록하는 데 사용됩니다.
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리
    func debug(_ message: String, category: LogCategory)

    /// 일반적인 정보를 로깅합니다. 애플리케이션의 정상적인 동작을 기록하는 데 사용됩니다.
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리
    func info(_ message: String, category: LogCategory)

    /// 경고 메시지를 로깅합니다. 잠재적인 문제나 예상치 못한 상황을 기록하는 데 사용됩니다.
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리
    func warning(_ message: String, category: LogCategory)

    /// 오류 메시지를 로깅합니다. 실패한 작업이나 예외 상황을 기록하는 데 사용됩니다.
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리
    func error(_ message: String, category: LogCategory)

    /// 심각한 오류 메시지를 로깅합니다. 즉각적인 조치가 필요한 중대한 문제를 기록하는 데 사용됩니다.
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - category: 로그의 카테고리
    func critical(_ message: String, category: LogCategory)
}
