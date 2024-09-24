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
///         let appError = error as? AppError ?? AppError.unknown(error)
///         handleGlobalError(appError)
///         return nil
///     }
///
///     func handleGlobalError(_ error: AppError) {
///         // 에러 로깅
///         print("글로벌 에러 발생: \(error.errorDescription)")
///
///         // 사용자에게 알림
///         // showAlert(message: error.errorDescription)
///
///         // 에러 리포팅 서비스에 전송
///         // ErrorReportingService.send(error)
///     }
/// }
///
/// let globalHandler = AppGlobalErrorHandler()
/// globalHandler.handle(someError)
/// ```
protocol GlobalErrorHandler: ErrorHandler {
    /// 글로벌 수준에서 AppError를 처리합니다.
    ///
    /// - Parameter error: 처리할 AppError 객체
    func handleGlobalError(_ error: AppError)
}
