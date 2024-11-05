//
//  KeychainDomainError.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Core
import Security

// MARK: - Keychain Domain Errors
enum KeychainDomainError: DomainError {
    case accessFailed(OSStatus, String)
    case unexpectedData
    case dataConversionFailed
    
    var errorDescription: String {
        switch self {
        case .accessFailed(let status, let operation):
            return "Keychain \(operation) 실패: \(secErrorMessage(for: status))"
        case .unexpectedData:
            return "Keychain에서 예상치 못한 데이터 형식 발견"
        case .dataConversionFailed:
            return "데이터 변환 실패"
        }
    }
    
    var errorCode: Int {
        switch self {
        case .accessFailed: return 3001
        case .unexpectedData: return 3002
        case .dataConversionFailed: return 3003
        }
    }
    
    var underlyingError: Error? { nil }
    
    private func secErrorMessage(for status: OSStatus) -> String {
        switch status {
        case errSecItemNotFound:
            return "항목을 찾을 수 없음"
        case errSecDuplicateItem:
            return "중복된 항목"
        case errSecAuthFailed:
            return "인증 실패"
        default:
            return "에러 코드: \(status)"
        }
    }
}
