//
//  StorageErrorHandler.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Core
import Security

final class StorageErrorHandler: DomainErrorHandler {
    func handleDomainError(_ error: DomainError) -> BusinessError? {
        switch error {
        case let keychainError as KeychainDomainError:
            return handleKeychainError(keychainError)
        case let storageError as StorageDomainError:
            return handleStorageError(storageError)
        default:
            return StorageBusinessError.storageAccessError("알 수 없는 저장소 오류가 발생했습니다")
        }
    }
    
    func handle(_ error: Error) -> AppError? {
        if let domainError = error as? DomainError {
            return handleDomainError(domainError)
        }
        return BaseAppError(description: "알 수 없는 저장소 오류가 발생했습니다", code: 9999)
    }
    
    // MARK: - Private Methods
    private func handleKeychainError(_ error: KeychainDomainError) -> BusinessError {
        switch error {
        case .accessFailed(let status, _):
            switch status {
            case errSecItemNotFound:
                return StorageBusinessError.invalidData(error.errorDescription)
            case errSecDuplicateItem:
                return StorageBusinessError.storageAccessError(error.errorDescription)
            case errSecAuthFailed:
                return StorageBusinessError.securityError(error.errorDescription)
            default:
                return StorageBusinessError.securityError(error.errorDescription)
            }
            
        case .unexpectedData:
            return StorageBusinessError.invalidData(error.errorDescription)
            
        case .dataConversionFailed:
            return StorageBusinessError.invalidData(error.errorDescription)
        }
    }
    
    private func handleStorageError(_ error: StorageDomainError) -> BusinessError {
        switch error {
        case .dataNotFound(let key):
            return StorageBusinessError.invalidData("데이터를 찾을 수 없습니다: \(key.rawValue)")
        case .encodingFailed(let type), .decodingFailed(let type):
            return StorageBusinessError.invalidData("\(type) 데이터 변환 실패")
        case .saveFailed(let key), .deleteFailed(let key):
            return StorageBusinessError.storageAccessError("저장소 접근 실패: \(key.rawValue)")
        case .directoryCreationFailed:
            return StorageBusinessError.storageAccessError("저장소 초기화 실패")
        }
    }
}
