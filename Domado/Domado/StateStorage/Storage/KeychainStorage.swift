//
//  KeychainStorage.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation

final class KeychainStorage: StorageProvider {
    private let service: String
    
    init(service: String = Bundle.main.bundleIdentifier ?? "com.domado") {
        self.service = service
    }
    
    func save(_ data: Data, for key: StorageKey) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // 기존 항목 삭제
        SecItemDelete(query as CFDictionary)
        
        // 새 항목 저장
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainDomainError.accessFailed(status, "저장")
        }
    }
    
    func read(for key: StorageKey) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainDomainError.accessFailed(status, "읽기")
        }
        
        guard let data = result as? Data else {
            throw KeychainDomainError.unexpectedData
        }
        
        return data
    }
    
    func delete(for key: StorageKey) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainDomainError.accessFailed(status, "삭제")
        }
    }
    
    func exists(for key: StorageKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: false
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}
