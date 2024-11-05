//
//  StorageBusinessError.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Core

enum StorageBusinessError: BusinessError {
    case invalidData(String)
    case securityError(String)
    case storageAccessError(String)
    
    var errorDescription: String {
        switch self {
        case .invalidData(let message):
            return "데이터 처리 오류: \(message)"
        case .securityError(let message):
            return "보안 오류: \(message)"
        case .storageAccessError(let message):
            return "저장소 접근 오류: \(message)"
        }
    }
    
    var errorCode: Int {
        switch self {
        case .invalidData: return 2001
        case .securityError: return 2002
        case .storageAccessError: return 2003
        }
    }
    
    var isUserFacing: Bool {
        switch self {
        case .invalidData: return false
        case .securityError: return true
        case .storageAccessError: return true
        }
    }
}
