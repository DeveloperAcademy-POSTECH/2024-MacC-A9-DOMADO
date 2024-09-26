//
//  DomainError.swift
//  Core
//
//  Created by 이종선 on 9/24/24.
//

/// 도메인 특화 에러를 나타내는 프로토콜입니다.
///
/// 이 프로토콜은 특정 기술적 도메인(예: 네트워킹, 데이터베이스, 파일 시스템 등)에서
/// 발생할 수 있는 에러를 표현하는 데 사용됩니다. `AppError`를 상속받아
/// 기본적인 에러 정보를 제공하면서 도메인 특화 정보를 추가할 수 있습니다.
///
/// ## 예시:
///
/// ```swift
/// enum NetworkError: DomainError {
///     case connectionFailed(URLError)
///     case invalidStatusCode(Int)
///
///     var errorDescription: String {
///         switch self {
///         case .connectionFailed(let error):
///             return "네트워크 연결 실패: \(error.localizedDescription)"
///         case .invalidStatusCode(let code):
///             return "잘못된 상태 코드 수신: \(code)"
///         }
///     }
///
///     var errorCode: Int {
///         switch self {
///         case .connectionFailed:
///             return 2001
///         case .invalidStatusCode:
///             return 2002
///         }
///     }
///
///     var underlyingError: Error? {
///         switch self {
///         case .connectionFailed(let error):
///             return error
///         case .invalidStatusCode:
///             return nil
///         }
///     }
/// }
///
/// // 사용 예시
/// func fetchData(from url: URL) throws {
///     // 네트워크 요청 시뮬레이션
///     throw NetworkError.connectionFailed(URLError(.notConnectedToInternet))
/// }
///
/// do {
///     try fetchData(from: URL(string: "https://api.example.com")!)
/// } catch let error as DomainError {
///     print("도메인 에러 발생: \(error.errorDescription)")
///     if let underlyingError = error.underlyingError {
///         print("기저 에러: \(underlyingError)")
///     }
/// }
/// ```
///
/// 이 예시에서 `NetworkError`는 `DomainError` 프로토콜을 준수하며,
/// 네트워크 관련 에러를 표현합니다. `underlyingError` 속성을 통해
/// 원본 시스템 에러에 접근할 수 있습니다.
public protocol DomainError: AppError {
    /// 이 에러의 근본 원인이 되는 기저 에러입니다.
    ///
    /// 이 속성은 시스템 레벨이나 외부 라이브러리에서 발생한 원본 에러를
    /// 캡슐화하는 데 사용될 수 있습니다. 항상 값이 있는 것은 아니며,
    /// 필요한 경우에만 제공됩니다.
    var underlyingError: Error? { get }
}
