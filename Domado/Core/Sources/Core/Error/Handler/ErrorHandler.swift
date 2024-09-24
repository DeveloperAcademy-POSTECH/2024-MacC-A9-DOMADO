//
//  ErrorHandler.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 기본 에러 핸들러 프로토콜입니다.
///
/// 이 프로토콜은 모든 유형의 에러를 처리할 수 있는 기본적인 인터페이스를 정의합니다.
/// 애플리케이션의 다양한 레이어에서 발생하는 에러를 처리하는 데 사용될 수 있습니다.
///
/// ## 예시:
///
/// ```swift
/// class GeneralErrorHandler: ErrorHandler {
///     func handle(_ error: Error) -> AppError? {
///         print("에러 발생: \(error.localizedDescription)")
///         // 에러 로깅, 사용자에게 알림 등의 작업 수행
///         return nil
///     }
/// }
///
/// let handler = GeneralErrorHandler()
/// if let appError = handler.handle(someError) {
///     // appError 처리
/// }
/// ```
protocol ErrorHandler {
    /// 주어진 에러를 처리합니다.
    ///
    /// - Parameter error: 처리할 Error 객체
    /// - Returns: 처리 결과로 변환된 AppError 객체.
    ///            nil을 반환하면 에러가 완전히 처리되었음을 의미합니다.
    func handle(_ error: Error) -> AppError?
}
