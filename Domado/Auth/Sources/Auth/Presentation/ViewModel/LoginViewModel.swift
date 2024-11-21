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
                let signInUser = try await authUseCase.signIn(
                    email: email,
                    password: password
                )
                
                let currentUser = AppUser(id: signInUser.id, name: signInUser.name, hasRegisteredPayments: signInUser.hasRegisteredPayments, currentRentalId: signInUser.currentRentalId, stampCount: signInUser.stampCount, couponCount: signInUser.couponCount)
                
                self.appState.updateUserState(to: currentUser)
                
            } catch let error as AuthError {
                //TODO: UseCase에서 로그인 정보 검증 로직 추가 + 검증에 따른 error 처리
                // TODO: 사용자에게 보여줘야하는 에러 처리
            } catch {
                
            }
            
            handleLoading(false)
        }
    }
    
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
    
}
