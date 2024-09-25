//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/25/24.
//
import Foundation

/// 애플리케이션에서 예상하지 못한 에러를 처리하기 위한 래퍼 구조체입니다.
///
/// 이 구조체는 `AppError` 프로토콜을 준수하며, 알 수 없는 에러나
/// 예상치 못한 에러를 애플리케이션의 에러 처리 시스템에 통합하는 데 사용됩니다.
///
/// ## 사용 예시:
///
/// ```swift
/// do {
///     try someRiskyOperation()
/// } catch {
///     let unknownError = UnknownError(error)
///     handleError(unknownError)
/// }
/// ```
///
/// - Note: 이 구조체는 주로 글로벌 에러 핸들러에서 사용되며,
///         알 수 없는 에러를 애플리케이션의 에러 처리 흐름에 맞게 변환합니다.
struct UnknownError: AppError {
    /// 원본 에러 객체입니다.
    ///
    /// 이 속성은 래핑된 원본 에러에 대한 참조를 유지합니다.
    /// 디버깅이나 자세한 에러 분석이 필요할 때 사용할 수 있습니다.
    let underlyingError: Error
    
    /// 에러에 대한 사용자 친화적인 설명입니다.
    ///
    /// 이 설명은 원본 에러의 `localizedDescription`을 포함하여,
    /// 알 수 없는 에러가 발생했음을 나타냅니다.
    var errorDescription: String {
        "An unknown error occurred: \(underlyingError.localizedDescription)"
    }
    
    /// 이 에러 타입에 대한 고유한 에러 코드입니다.
    ///
    /// 알 수 없는 에러를 나타내는 999를 사용합니다.
    /// 이 값은 로깅이나 에러 추적 시 유용할 수 있습니다.
    var errorCode: Int { 999 }
    
    /// UnknownError 인스턴스를 생성합니다.
    ///
    /// - Parameter error: 래핑할 원본 Error 객체
    ///
    /// 이 이니셜라이저는 어떤 타입의 Error라도 받아 UnknownError로 래핑합니다.
    init(_ error: Error) {
        self.underlyingError = error
    }
}

