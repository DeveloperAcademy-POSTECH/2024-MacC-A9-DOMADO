//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//


import Foundation
import Combine

@MainActor
public final class AuthViewModel: ObservableObject {
    // MARK: - Types
    
    public enum AuthState {
        case idle
        case authenticating
        case authenticated(User)
        case error(AuthError)
    }
    
    // MARK: - Published Properties
    
    @Published private(set) var authState: AuthState = .idle
    @Published private(set) var isLoading = false
    
    // MARK: - Private Properties
    
    private let authUseCase: AuthUseCase
    private var currentAuthTask: Task<Void, Never>?
    
    // MARK: - Init
    
    public init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        checkInitialAuthState()
    }
    
    // MARK: - Public Methods
    
    public func signUp(email: String, password: String, name: String, phone: String) {
        guard !isLoading else { return }
        
        currentAuthTask?.cancel()
        currentAuthTask = Task { [weak self, authUseCase] in
            guard let self else { return }
            
            handleLoading(true)
            
            do {
                try await authUseCase.signUp(
                    email: email,
                    password: password,
                    name: name,
                    phone: phone
                )
                 self.updateAuthState(.idle)
            } catch let error as AuthError {
                 self.updateAuthState(.error(error))
            } catch {
                 self.updateAuthState(.error(.unknown))
            }
            
             handleLoading(false)
        }
    }
    
    public func signIn(email: String, password: String) {
        guard !isLoading else { return }
        
        currentAuthTask?.cancel()
        currentAuthTask = Task { [weak self, authUseCase] in
            guard let self else { return }
            
             handleLoading(true)
            
            do {
                let user = try await authUseCase.signIn(
                    email: email,
                    password: password
                )
                 self.updateAuthState(.authenticated(user))
            } catch let error as AuthError {
                 self.updateAuthState(.error(error))
            } catch {
                 self.updateAuthState(.error(.unknown))
            }
            
             handleLoading(false)
        }
    }
    
    public func signOut() {
        guard !isLoading else { return }
        
        currentAuthTask?.cancel()
        currentAuthTask = Task { [weak self, authUseCase] in
            guard let self else { return }
            
             handleLoading(true)
            
            do {
                try await authUseCase.signOut()
                 self.updateAuthState(.idle)
            } catch let error as AuthError {
                 self.updateAuthState(.error(error))
            } catch {
                 self.updateAuthState(.error(.unknown))
            }
            
             handleLoading(false)
        }
    }
    
    public func getCurrentUser() {
        guard !isLoading else { return }
        
        currentAuthTask?.cancel()
        currentAuthTask = Task { [weak self, authUseCase] in
            guard let self else { return }
            
             handleLoading(true)
            
            do {
                let user = try await authUseCase.getCurrentUser()
                 self.updateAuthState(.authenticated(user))
            } catch let error as AuthError {
                 self.updateAuthState(.error(error))
            } catch {
                 self.updateAuthState(.error(.unknown))
            }
            
             handleLoading(false)
        }
    }
    
    public func clearError() {
        if case .error = authState {
            authState = .idle
        }
    }
    
    // MARK: - Private Methods
    
    private func checkInitialAuthState() {
        if authUseCase.isAuthenticated() {
            getCurrentUser()
        }
    }
    
    @MainActor
    private func updateAuthState(_ newState: AuthState) {
        authState = newState
    }
    
    @MainActor
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    // MARK: - Deinit
    
    deinit {
        currentAuthTask?.cancel()
    }
}
