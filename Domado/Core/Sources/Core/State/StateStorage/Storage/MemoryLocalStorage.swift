//
//  MemoryLocalStorage.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Foundation

// MARK: - 메모리 기반 상태 저장소 
final class MemoryLocalStorage: StorageProvider {
    private var storage: [String: Data] = [:]
    
    func save(_ data: Data, for key: StorageKey) throws {
        storage[key.rawValue] = data
    }
    
    func read(for key: StorageKey) throws -> Data {
        guard let data = storage[key.rawValue] else {
            throw StorageDomainError.dataNotFound(key: key)
        }
        return data
    }
    
    func delete(for key: StorageKey) throws {
        storage.removeValue(forKey: key.rawValue)
    }
    
    func exists(for key: StorageKey) -> Bool {
        storage[key.rawValue] != nil
    }
}
