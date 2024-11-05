//
//  UserDefaultsStorage.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation

final class UserDefaultsStorage: StorageProvider{
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func save(_ data: Data, for key: StorageKey) throws {
        defaults.set(data, forKey: key.rawValue)
        
        // 저장 확인
        guard defaults.data(forKey: key.rawValue) != nil else {
            throw StorageDomainError.saveFailed(key: key)
        }
    }
    
    func read(for key: StorageKey) throws -> Data {
        guard let data = defaults.data(forKey: key.rawValue) else {
            throw StorageDomainError.dataNotFound(key: key)
        }
        return data
    }
    
    func delete(for key: StorageKey) throws {
        defaults.removeObject(forKey: key.rawValue)
        
        // 삭제 확인
        guard defaults.object(forKey: key.rawValue) == nil else {
            throw StorageDomainError.deleteFailed(key: key)
        }
    }
     
    func exists(for key: StorageKey) -> Bool {
        defaults.object(forKey: key.rawValue) != nil
    }
}
