//
//  BaseResponse.swift
//  Core
//
//  Created by 이종선 on 11/19/24.
//

public struct BaseResponse<T: Codable>: Codable {
    public let success: Bool
    public let data: T?
    public let error: ErrorResponse?
    
    public struct ErrorResponse: Codable {
        public let code: String
        public let message: String
    }
}

// MARK: - Error Handling Extensions
extension BaseResponse {
    /// 성공 여부를 확인합니다.
    public var isSuccess: Bool {
        success && error == nil
    }
    
    /// 에러 메시지를 반환합니다.
    public var errorMessage: String? {
        error?.message
    }
    
    /// 에러 코드를 반환합니다.
    public var errorCode: String? {
        error?.code
    }
}

public struct Nothing: Codable {}
