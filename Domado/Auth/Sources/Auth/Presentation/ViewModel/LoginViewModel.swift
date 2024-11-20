//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//

import Core
import Foundation

@MainActor
public final class LoginViewModel: ObservableObject {
    
    @Published private(set) var isLoading = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    private let authUseCase: AuthUseCase
    private let appState: AppState
    
    // MARK: - Init
    
    public init(authUseCase: AuthUseCase, appState: AppState) {
        self.authUseCase = authUseCase
        self.appState = appState
    }
    
    // MARK: - Public Methods
    
    public func signIn() {
        guard !isLoading else { return }
        
        Task { [weak self, authUseCase] in
            guard let self else { return }
            
            handleLoading(true)
            
            do {
                let user = try await authUseCase.signIn(
                    email: email,
                    password: password
                )
                
                self.appState.updateAuthState(to: .authenticated)
                
            } catch let error as AuthError {
                
            } catch {
            }
            
            handleLoading(false)
        }
    }
    

    @MainActor
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
    
}
