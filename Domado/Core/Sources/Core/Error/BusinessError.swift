//
//  BusinessError.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 비즈니스 로직 관련 에러를 나타내는 프로토콜입니다.
///
/// 이 프로토콜은 애플리케이션의 비즈니스 규칙이나 워크플로우와 관련된
/// 에러를 표현하는 데 사용됩니다. `AppError`를 상속받아 기본적인 에러 정보를
/// 제공하면서 비즈니스 로직 특화 정보를 추가할 수 있습니다.
///
/// ## 예시:
///
/// ```swift
/// enum UserError: BusinessError {
///     case invalidCredentials
///     case insufficientFunds(balance: Double, required: Double)
///
///     var errorDescription: String {
///         switch self {
///         case .invalidCredentials:
///             return "잘못된 사용자 인증 정보입니다. 아이디와 비밀번호를 확인해주세요."
///         case .insufficientFunds(let balance, let required):
///             return "잔액이 부족합니다. 현재 잔액: \(balance), 필요 금액: \(required)"
///         }
///     }
///
///     var errorCode: Int {
///         switch self {
///         case .invalidCredentials:
///             return 3001
///         case .insufficientFunds:
///             return 3002
///         }
///     }
///
///     var isUserFacing: Bool {
///         return true  // 모든 UserError는 사용자에게 직접 표시될 수 있습니다.
///     }
/// }
///
/// // 사용 예시
/// func processPayment(amount: Double) throws {
///     let currentBalance = 50.0
///     guard currentBalance >= amount else {
///         throw UserError.insufficientFunds(balance: currentBalance, required: amount)
///     }
///     // 결제 처리 로직...
/// }
///
/// do {
///     try processPayment(amount: 100.0)
/// } catch let error as BusinessError {
///     if error.isUserFacing {
///         print("사용자에게 표시할 에러: \(error.errorDescription)")
///     } else {
///         print("내부 처리용 에러: \(error.errorDescription)")
///     }
/// }
/// ```
///
/// 이 예시에서 `UserError`는 `BusinessError` 프로토콜을 준수하며,
/// 사용자 관련 비즈니스 로직 에러를 표현합니다. `isUserFacing` 속성을 통해
/// 이 에러가 사용자에게 직접 표시될 수 있는지 여부를 나타냅니다.
protocol BusinessError: AppError {
    /// 이 에러가 사용자에게 직접 표시될 수 있는지를 나타냅니다.
    ///
    /// `true`인 경우, 이 에러의 `errorDescription`은 사용자 인터페이스에
    /// 직접 표시하기에 적합한 메시지임을 의미합니다. `false`인 경우,
    /// 내부 로깅이나 개발자용 정보로 사용되어야 함을 나타냅니다.
    var isUserFacing: Bool { get }
}
