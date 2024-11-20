//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

/// AuthUseCase : 인증 / 인가를 위한 UseCase 정의 
public protocol AuthUseCase {
    func signUp(email: String, password: String, name: String, phone: String) async throws
    func signIn(email: String, password: String) async throws -> User
    func signOut() async throws
    func getCurrentUser() async throws -> User
    func isAuthenticated() -> Bool
}
