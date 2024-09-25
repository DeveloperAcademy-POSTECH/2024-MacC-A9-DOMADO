//
//  AppError.swift
//  Core
//
//  Created by 이종선 on 9/22/24.
//

/// 애플리케이션 전체에서 사용되는 기본 에러 프로토콜입니다.
///
/// 모든 커스텀 에러 타입은 이 프로토콜을 준수해야 합니다.
/// 이 프로토콜을 준수함으로써 일관된 에러 처리와 보고가 가능해집니다.
///
/// ## 예시:
///
/// ```swift
/// enum NetworkError: AppError {
///     case connectionFailed
///     case invalidResponse
///
///     var errorDescription: String {
///         switch self {
///         case .connectionFailed:
///             return "네트워크 연결에 실패했습니다. 인터넷 연결을 확인해주세요."
///         case .invalidResponse:
///             return "서버로부터 잘못된 응답을 받았습니다. 나중에 다시 시도해주세요."
///         }
///     }
///
///     var errorCode: Int {
///         switch self {
///         case .connectionFailed:
///             return 1001
///         case .invalidResponse:
///             return 1002
///         }
///     }
/// }
///
/// // 사용 예시
/// func fetchData() throws {
///     throw NetworkError.connectionFailed
/// }
///
/// do {
///     try fetchData()
/// } catch let error as AppError {
///     print("에러 발생: \(error.errorDescription), 코드: \(error.errorCode)")
/// } catch {
///     print("알 수 없는 에러 발생")
/// }
/// ```
///
/// 이 예시에서 `NetworkError`는 `AppError` 프로토콜을 준수하며,
/// 각 에러 케이스에 대해 사용자 친화적인 설명과 고유한 에러 코드를 제공합니다.
protocol AppError: Error {
    /// 에러에 대한 사용자 친화적인 설명입니다.
    ///
    /// 이 속성은 사용자에게 표시하거나 로깅에 사용할 수 있는
    /// 읽기 쉬운 에러 메시지를 제공해야 합니다.
    var errorDescription: String { get }
    
    /// 에러를 식별하기 위한 고유 코드입니다.
    ///
    /// 이 코드는 에러를 고유하게 식별하고 분류하는 데 사용됩니다.
    /// 로깅, 분석, 또는 디버깅 목적으로 활용될 수 있습니다.
    var errorCode: Int { get }
}

