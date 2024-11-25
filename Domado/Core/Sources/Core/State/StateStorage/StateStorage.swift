//
//  StateStorage.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation

public final class StateStorage {
    private let localStorage: StorageProvider
    private let userDefaults: UserDefaultsStorage
    private let keychain: KeychainStorage
    private let errorHandler: StorageErrorHandler
    
    public init(
        localStorage: StorageProvider,
        userDefaults: StorageProvider,
        keychain: StorageProvider,
        errorHandler: StorageErrorHandler
    ) {
        self.localStorage = localStorage as! LocalStorage
        self.userDefaults = userDefaults as! UserDefaultsStorage
        self.keychain = keychain as! KeychainStorage
        self.errorHandler = errorHandler
    }
    
    public convenience init() throws {
        let errorHandler = StorageErrorHandler()
        
        do {
            self.init(
                localStorage: try LocalStorage(),
                userDefaults: UserDefaultsStorage(),
                keychain: KeychainStorage(),
                errorHandler: errorHandler
            )
        } catch {
            throw error
        }
    }
    
    // MARK: - Generic Storage Methods
    
    /// 제네릭 타입의 값을 저장소에 저장합니다.
    /// - Parameters:
    ///   - value: 저장할 값
    ///   - key: 저장소 키
    public func setValue<T: Encodable>(_ value: T, for key: StorageKey) throws {
        do {
            let data = try JSONEncoder().encode(value)
            
            switch key {
            case .accessToken, .refreshToken, .userData, .deviceToken:
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
    public func value<T: Decodable>(for key: StorageKey) throws -> T {
        do {
            let data: Data = try {
                switch key {
                case .accessToken, .refreshToken, .userData, .deviceToken:
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
    public func removeValue(for key: StorageKey) throws {
        do {
            switch key {
            case .accessToken, .refreshToken, .userData, .deviceToken:
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
    public func hasValue(for key: StorageKey) -> Bool {
        switch key {
        case .accessToken, .refreshToken, .userData, .deviceToken:
            return keychain.exists(for: key)
            
        case .hasSeenOnboarding, .preferredLanguage,
             .selectedPaymentMethod, .pushNotificationEnabled:
            return userDefaults.exists(for: key)
            
        case .activeRide:
            return localStorage.exists(for: key)
        }
    }
    
    /// 모든 저장소의 데이터를 삭제합니다.
    public func clearAll() throws {
        do {
            // Keychain 데이터 삭제
            try removeValue(for: .accessToken)
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

/// 상태저장소 초기화 에러시 상태 복구 로직
public extension StateStorage {
    /// 메모리 기반의 fallback storage를 생성합니다.
    static func createFallback() -> StateStorage {
        do {
            // 임시 디렉토리를 사용하는 LocalStorage 생성
            let tempLocalStorage = try createTempLocalStorage()
            
            return StateStorage(
                localStorage: tempLocalStorage,
                userDefaults: UserDefaultsStorage(),
                keychain: KeychainStorage(),
                errorHandler: StorageErrorHandler()
            )
        } catch {
            // 최후의 수단: 메모리 전용 스토리지
            return createMemoryOnlyStorage()
        }
    }
    
    private static func createTempLocalStorage() throws -> LocalStorage {
        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("FallbackStorage", isDirectory: true)
        
        return try LocalStorage(fileManager: FileManager.default, baseDirectory: tempDirectory) 
    }
    
    private static func createMemoryOnlyStorage() -> StateStorage {
        let memoryLocalStorage = MemoryLocalStorage()
        
        return StateStorage(
            localStorage: memoryLocalStorage,
            userDefaults: UserDefaultsStorage(),
            keychain: KeychainStorage(),
            errorHandler: StorageErrorHandler()
        )
    }
}
