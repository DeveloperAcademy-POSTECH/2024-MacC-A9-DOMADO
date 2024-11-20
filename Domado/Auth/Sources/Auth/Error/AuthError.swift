//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

import Core

// Domain Errors
public enum AuthError: BusinessError {
    case invalidCredentials
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case refreshTokenExpired
    case networkError(NetworkError)
    case invalidResponse
    case invalidToken
    case unknown
    
    public var isUserFacing: Bool { true }
    
    public var errorDescription: String {
        switch self {
        case .invalidCredentials:
            return "이메일 또는 비밀번호가 올바르지 않습니다."
        case .invalidEmail:
            return "올바른 이메일 형식이 아닙니다."
        case .weakPassword:
            return "비밀번호는 8자 이상이어야 하며, 숫자와 특수문자를 포함해야 합니다."
        case .emailAlreadyInUse:
            return "이미 사용 중인 이메일입니다."
        case .refreshTokenExpired:
            return "로그인이 만료되었습니다. 다시 로그인해주세요."
        case .networkError(let error):
            return error.errorDescription
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다."
        case .invalidToken:
            return "인증 토큰이 유효하지 않습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
    
    public var errorCode: Int {
        switch self {
        case .invalidCredentials: return 2001
        case .invalidEmail: return 2002
        case .weakPassword: return 2003
        case .emailAlreadyInUse: return 2004
        case .refreshTokenExpired: return 2005
        case .networkError(let error): return error.errorCode
        case .invalidResponse: return 2006
        case .invalidToken: return 2007
        case .unknown: return 2000
        }
    }
}
