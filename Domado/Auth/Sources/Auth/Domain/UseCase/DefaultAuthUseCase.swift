//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//

import Foundation

public final class DefaultAuthUseCase: AuthUseCase {
    private let authRepository: AuthRepository
    
    public init(
        authRepository: AuthRepository ) {
        self.authRepository = authRepository
    }
    
    public func signUp(email: String, password: String, name: String, phone: String) async throws {
       
        try await authRepository.signUp(
            email: email,
            password: password,
            name: name,
            phone: phone
        )
    }
    
    public func signIn(email: String, password: String) async throws -> User {
       
        return try await authRepository.signIn(email: email, password: password)
    }
    
    public func signOut() async throws {

        try await authRepository.signOut()
    }
    
    public func getCurrentUser() async throws -> User {
        
        return try await authRepository.getCurrentUser()
    }
    
    public func isAuthenticated() -> Bool {
        authRepository.isAuthenticated()
    }
    
}
