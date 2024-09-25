//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 애플리케이션 전체에서 발생하는 모든 에러를 최종적으로 처리하는 글로벌 핸들러 프로토콜입니다.
///
/// 이 핸들러는 다른 핸들러에서 처리되지 않은 에러를 포착하고 처리하는 역할을 합니다.
/// 주로 로깅, 사용자에게 일반적인 에러 메시지 표시, 에러 리포팅 등의 작업을 수행합니다.
///
/// ## 예시:
///
/// ```swift
/// class AppGlobalErrorHandler: GlobalErrorHandler {
///     func handle(_ error: Error) -> AppError? {
///         let appError: AppError
///         if let businessError = error as? BusinessError {
///             appError = businessError
///         } else if let knownError = error as? AppError {
///             appError = knownError
///         } else {
///             appError = UnknownError(error)
///         }
///
///         handleGlobalError(appError)
///         return nil  // 에러가 완전히 처리되었음을 나타냅니다.
///     }
///
///     func handleGlobalError(_ error: AppError) {
///         // 에러 로깅
///         logError(error)
///
///         // 사용자에게 알림
///         if let businessError = error as? BusinessError {
///             showAlertToUser(message: businessError.userMessage)
///         } else {
///             showAlertToUser(message: "An unexpected error occurred. Please try again later.")
///         }
///
///         // 에러 리포팅 서비스에 전송
///         sendErrorReport(error)
///     }
///
///     private func logError(_ error: AppError) {
///         print("Global error occurred: \(error.errorDescription) (Code: \(error.errorCode))")
///     }
///
///     private func showAlertToUser(message: String) {
///         // 실제 구현에서는 UI 프레임워크를 사용하여 알림을 표시합니다.
///         print("Alert shown to user: \(message)")
///     }
///
///     private func sendErrorReport(_ error: AppError) {
///         // 실제 구현에서는 에러 리포팅 서비스를 사용합니다.
///         print("Error report sent for: \(error.errorDescription)")
///     }
/// }
/// ```
protocol GlobalErrorHandler: ErrorHandler {
    /// 글로벌 수준에서 AppError를 처리합니다.
    ///
    /// - Parameter error: 처리할 AppError 객체
    func handleGlobalError(_ error: AppError)
}
