//
//  StateStorage.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation

final class StateStorage {
    private let localStorage: LocalStorage
    private let userDefaults: UserDefaultsStorage
    private let keychain: KeychainStorage
    private let errorHandler: StorageErrorHandler
    
    init() throws {
        self.errorHandler = StorageErrorHandler()
        self.localStorage = try LocalStorage()
        self.userDefaults = UserDefaultsStorage()
        self.keychain = KeychainStorage()
    }
    
    // MARK: - Generic Storage Methods
    
    /// 제네릭 타입의 값을 저장소에 저장합니다.
    /// - Parameters:
    ///   - value: 저장할 값
    ///   - key: 저장소 키
    func setValue<T: Encodable>(_ value: T, for key: StorageKey) throws {
        do {
            let data = try JSONEncoder().encode(value)
            
            switch key {
            case .authToken, .refreshToken, .userData:
                try keychain.save(data, for: key)
                
            case .hasSeenOnboarding, .preferredLanguage,
                 .selectedPaymentMethod, .pushNotificationEnabled:
                try userDefaults.save(data, for: key)
                
            case .activeRide:
                try localStorage.save(data, for: key)
            }
        } catch let error as StorageDomainError {
            if let businessError = errorHandler.handleDomainError(error) {
                throw businessError
            }
            throw error
        } catch {
            throw StorageDomainError.encodingFailed(type: T.self)
        }
    }
    
    /// 저장소에서 제네릭 타입의 값을 읽어옵니다.
    /// - Parameter key: 저장소 키
    /// - Returns: 저장된 값
    func value<T: Decodable>(for key: StorageKey) throws -> T {
        do {
            let data: Data = try {
                switch key {
                case .authToken, .refreshToken, .userData:
                    return try keychain.read(for: key)
                    
                case .hasSeenOnboarding, .preferredLanguage,
                     .selectedPaymentMethod, .pushNotificationEnabled:
                    return try userDefaults.read(for: key)
                    
                case .activeRide:
                    return try localStorage.read(for: key)
                }
            }()
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as StorageDomainError {
            if let businessError = errorHandler.handleDomainError(error) {
                throw businessError
            }
            throw error
        } catch {
            throw StorageDomainError.decodingFailed(type: T.self)
        }
    }
    
    /// 저장소에서 특정 키의 값을 삭제합니다.
    /// - Parameter key: 저장소 키
    func removeValue(for key: StorageKey) throws {
        do {
            switch key {
            case .authToken, .refreshToken, .userData:
                try keychain.delete(for: key)
                
            case .hasSeenOnboarding, .preferredLanguage,
                 .selectedPaymentMethod, .pushNotificationEnabled:
                try userDefaults.delete(for: key)
                
            case .activeRide:
                try localStorage.delete(for: key)
            }
        } catch let error as StorageDomainError {
            if let businessError = errorHandler.handleDomainError(error) {
                throw businessError
            }
            throw error
        }
    }
    
    /// 특정 키에 대한 값이 존재하는지 확인합니다.
    /// - Parameter key: 저장소 키
    /// - Returns: 값 존재 여부
    func hasValue(for key: StorageKey) -> Bool {
        switch key {
        case .authToken, .refreshToken, .userData:
            return keychain.exists(for: key)
            
        case .hasSeenOnboarding, .preferredLanguage,
             .selectedPaymentMethod, .pushNotificationEnabled:
            return userDefaults.exists(for: key)
            
        case .activeRide:
            return localStorage.exists(for: key)
        }
    }
    
    /// 모든 저장소의 데이터를 삭제합니다.
    func clearAll() throws {
        do {
            // Keychain 데이터 삭제
            try removeValue(for: .authToken)
            try removeValue(for: .refreshToken)
            try removeValue(for: .userData)
            
            // UserDefaults 데이터 삭제
            try removeValue(for: .hasSeenOnboarding)
            try removeValue(for: .preferredLanguage)
            try removeValue(for: .selectedPaymentMethod)
            try removeValue(for: .pushNotificationEnabled)
            
            // LocalStorage 데이터 삭제
            try removeValue(for: .activeRide)
        } catch let error as StorageDomainError {
            if let businessError = errorHandler.handleDomainError(error) {
                throw businessError
            }
            throw error
        }
    }
}
