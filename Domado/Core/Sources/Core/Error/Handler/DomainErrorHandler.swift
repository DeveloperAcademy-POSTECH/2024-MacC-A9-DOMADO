//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 도메인 특화 에러를 처리하는 핸들러 프로토콜입니다.
///
/// 이 프로토콜은 특정 기술적 도메인(예: 네트워킹, 데이터베이스 등)에서
/// 발생하는 에러를 처리하는 데 특화되어 있습니다.
///
/// ## 예시:
///
/// ```swift
/// class NetworkErrorHandler: DomainErrorHandler {
///     func handle(_ error: Error) -> AppError? {
///         guard let networkError = error as? NetworkError else {
///             return error as? AppError
///         }
///         return handleDomainError(networkError)
///     }
///
///     func handleDomainError(_ error: DomainError) -> BusinessError? {
///         guard let networkError = error as? NetworkError else { return nil }
///         switch networkError {
///         case .connectionFailed:
///             return BusinessError.serviceUnavailable
///         case .invalidResponse:
///             return BusinessError.unexpectedError
///         }
///     }
/// }
///
/// let handler = NetworkErrorHandler()
/// if let businessError = handler.handle(someNetworkError) as? BusinessError {
///     // businessError 처리
/// }
/// ```
protocol DomainErrorHandler: ErrorHandler {
    /// 도메인 특화 에러를 처리하고 필요한 경우 비즈니스 에러로 변환합니다.
    ///
    /// - Parameter error: 처리할 DomainError 객체
    /// - Returns: 처리 결과로 변환된 BusinessError 객체.
    ///            nil을 반환하면 에러가 완전히 처리되었음을 의미합니다.
    func handleDomainError(_ error: DomainError) -> BusinessError?
}
