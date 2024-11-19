//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

/// AuthUseCase : 인증 / 인가를 위한 UseCase 정의 
public protocol AuthUseCase {
    func signUp(email: String, password: String, name: String) async throws -> User
    func signIn(email: String, password: String) async throws
    func signOut() async throws
    func refreshTokenIfNeeded() async throws
    func getCurrentUser() async throws -> User?
}
