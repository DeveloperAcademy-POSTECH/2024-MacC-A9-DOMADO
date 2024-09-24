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
/// class ConcreteBusinessErrorHandler: BusinessErrorHandler {
///     func handle(_ error: Error) -> AppError? {
///         guard let businessError = error as? BusinessError else {
///             return error as? AppError // BusinessError가 아니면 그대로 전달
///         }
///         return handleBusinessError(businessError)
///     }
///
///     func handleBusinessError(_ error: BusinessError) -> AppError? {
///         // 에러 로깅
///         logBusinessError(error)
///
///         // 에러 타입에 따른 처리
///         switch error {
///         case let paymentError as PaymentError:
///             return handlePaymentError(paymentError)
///         // 다른 비즈니스 에러 타입들에 대한 case 추가...
///         default:
///             // 처리되지 않은 비즈니스 에러
///             return handleUnknownBusinessError(error)
///         }
///     }
///
///     private func handlePaymentError(_ error: PaymentError) -> AppError? {
///         switch error {
///         case .insufficientFunds:
///             // 잔액 부족 에러는 복구 시도 없이 사용자에게 직접 보여줌
///             return error.isUserFacing ? error : createGenericErrorForUser(from: error)
///         case .invalidTransaction:
///             // 유효하지 않은 거래 에러는 복구 시도
///             if recoverFromInvalidTransaction() {
///                 return nil // 복구 성공
///             } else {
///                 return createGenericErrorForUser(from: error)
///             }
///         }
///     }
///
///     private func recoverFromInvalidTransaction() -> Bool {
///         // 유효하지 않은 거래 복구 로직
///         // 예: 거래 재시도, 데이터 정정 등
///         print("Attempting to recover from invalid transaction...")
///         return false // 예시로 항상 실패 반환
///     }
///
///     private func handleUnknownBusinessError(_ error: BusinessError) -> AppError {
///         return error.isUserFacing ? error : createGenericErrorForUser(from: error)
///     }
///
///     private func logBusinessError(_ error: BusinessError) {
///         print("Business error occurred: \(error.errorDescription) (Code: \(error.errorCode))")
///     }
///
///     private func createGenericErrorForUser(from error: BusinessError) -> AppError {
///         return UserFacingAppError(
///             errorDescription: "An unexpected error occurred. Please try again later.",
///             errorCode: error.errorCode
///         )
///     }
/// }
///
/// // 사용자에게 보여줄 수 있는 일반적인 앱 에러
/// struct UserFacingAppError: AppError {
///     let errorDescription: String
///     let errorCode: Int
/// }
///
/// // 비즈니스 에러 예시
/// enum PaymentError: BusinessError {
///     case insufficientFunds(balance: Double, required: Double)
///     case invalidTransaction
///
///     var errorDescription: String {
///         switch self {
///         case .insufficientFunds(let balance, let required):
///             return "Insufficient funds. Current balance: \(balance), Required: \(required)"
///         case .invalidTransaction:
///             return "Invalid transaction"
///         }
///     }
///
///     var errorCode: Int {
///         switch self {
///         case .insufficientFunds: return 4001
///         case .invalidTransaction: return 4002
///         }
///     }
///
///     var isUserFacing: Bool {
///         switch self {
///         case .insufficientFunds: return true
///         case .invalidTransaction: return false
///         }
///     }
/// }
/// ```
protocol BusinessErrorHandler: ErrorHandler {
    /// 비즈니스 에러를 처리합니다.
    ///
    /// - Parameter error: 처리할 BusinessError 객체
    /// - Returns: 처리 결과로 변환된 AppError 객체.
    ///            nil을 반환하면 에러가 완전히 처리되었음을 의미합니다.
    ///            AppError를 반환하면 상위 레벨로 에러를 전파합니다.
    func handleBusinessError(_ error: BusinessError) -> AppError?
}
