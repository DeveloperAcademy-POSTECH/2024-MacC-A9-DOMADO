//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 비즈니스 로직 관련 에러를 처리하는 핸들러 프로토콜입니다.
///
/// 이 프로토콜은 애플리케이션의 비즈니스 규칙이나 워크플로우와 관련된
/// 에러를 처리하는 데 특화되어 있습니다.
///
/// ## 예시:
///
/// ```swift
/// class UserErrorHandler: BusinessErrorHandler {
///     func handle(_ error: Error) -> AppError? {
///         guard let businessError = error as? BusinessError else {
///             return error as? AppError
///         }
///         handleBusinessError(businessError)
///         return nil
///     }
///
///     func handleBusinessError(_ error: BusinessError) {
///         guard let userError = error as? UserError else { return }
///         switch userError {
///         case .invalidCredentials:
///             // 사용자에게 재로그인 요청
///             print("유효하지 않은 인증 정보입니다. 다시 로그인해 주세요.")
///         case .insufficientFunds:
///             // 잔액 부족 알림
///             print("잔액이 부족합니다. 충전 후 다시 시도해 주세요.")
///         }
///     }
/// }
///
/// let handler = UserErrorHandler()
/// handler.handle(someUserError)
/// ```
protocol BusinessErrorHandler: ErrorHandler {
    /// 비즈니스 에러를 처리합니다.
    ///
    /// - Parameter error: 처리할 BusinessError 객체
    func handleBusinessError(_ error: BusinessError)
}
