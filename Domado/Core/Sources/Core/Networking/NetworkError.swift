//
//  NetworkError.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

/// 네트워크 계층에서 발생할 수 있는 다양한 에러를 정의하는 열거형입니다.
/// `DomainError` 프로토콜을 채택하여, 사용자 친화적인 에러 메시지와 고유한 에러 코드를 제공합니다.
public enum NetworkError: DomainError {
    
    /// 잘못된 URL로 인해 요청이 실패한 경우.
    case invalidURL
    
    /// 네트워크 요청 자체가 실패한 경우. 기저 에러를 포함합니다.
    case requestFailed(underlyingError: Error)
    
    /// 서버로부터 유효하지 않은 응답을 받은 경우.
    case invalidResponse
    
    /// 응답 데이터를 디코딩하는 과정에서 실패한 경우. 기저 에러를 포함합니다.
    case decodingError(underlyingError: Error)
    
    /// 서버에서 에러 상태 코드와 함께 에러 메시지를 반환한 경우.
    case serverError(statusCode: Int, message: String?)
    
    /// 네트워크 요청이 시간 초과된 경우.
    case timeout
    
    /// 알 수 없는 에러가 발생한 경우. 기저 에러를 포함할 수 있습니다.
    case unknown(underlyingError: Error?)
    
    // MARK: - AppError Protocol Requirements
    
    /// 에러에 대한 사용자 친화적인 설명을 제공합니다.
    ///
    /// 각 에러 케이스에 대해 적절한 메시지를 반환하여 사용자에게 이해하기 쉬운 에러 정보를 제공합니다.
    public var errorDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다. 요청을 다시 시도해 주세요."
        case .requestFailed(let underlyingError):
            return "네트워크 요청에 실패했습니다: \(underlyingError.localizedDescription)"
        case .invalidResponse:
            return "유효하지 않은 응답을 받았습니다. 나중에 다시 시도해 주세요."
        case .decodingError(let underlyingError):
            return "데이터 해석에 실패했습니다: \(underlyingError.localizedDescription)"
        case .serverError(let statusCode, let message):
            if let message = message {
                return "서버 에러 (\(statusCode)): \(message)"
            } else {
                return "서버 에러 (\(statusCode))가 발생했습니다."
            }
        case .timeout:
            return "요청 시간이 초과되었습니다. 네트워크 연결을 확인하고 다시 시도해 주세요."
        case .unknown:
            return "알 수 없는 에러가 발생했습니다. 나중에 다시 시도해 주세요."
        }
    }
    
    /// 에러를 식별하기 위한 고유 코드를 반환합니다.
    ///
    /// 각 에러 케이스에 대해 고유한 정수 코드를 제공하여 에러를 식별하고 분류합니다.
    public var errorCode: Int {
        switch self {
        case .invalidURL:
            return 1001
        case .requestFailed:
            return 1002
        case .invalidResponse:
            return 1003
        case .decodingError:
            return 1004
        case .serverError(let statusCode, _):
            return statusCode
        case .timeout:
            return 1005
        case .unknown:
            return 1000
        }
    }
    
    // MARK: - DomainError Protocol Requirements
    
    /// 이 에러의 근본 원인이 되는 기저 에러를 반환합니다.
    ///
    /// 일부 에러 케이스는 기저 에러를 포함하여 원본 에러의 상세 정보를 제공합니다.
    /// 필요하지 않은 경우 `nil`을 반환합니다.
    public var underlyingError: Error? {
        switch self {
        case .invalidURL, .invalidResponse, .timeout, .serverError(_, _), .unknown:
            return nil
        case .requestFailed(let underlyingError),
             .decodingError(let underlyingError):
            return underlyingError
        }
    }
}
