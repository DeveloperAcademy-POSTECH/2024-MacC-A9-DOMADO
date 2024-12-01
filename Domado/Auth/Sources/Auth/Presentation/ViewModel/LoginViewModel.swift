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
    
    
    let authUseCase: AuthUseCase
    private let appState: AppState
    let router: Routing
    
    // MARK: - Init
    
    public init(authUseCase: AuthUseCase, appState: AppState, router: Routing) {
        self.authUseCase = authUseCase
        self.appState = appState
        self.router = router
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
                
                //MARK: currentRental 존재시 BikeStatus에 따라 AppState 업데이트
//                if signInUser.currentRentalId != nil {
//                    self.appState.updateRideState(.active)
//                }
                
                let currentUser = AppUser(id: signInUser.id, name: signInUser.name, hasRegisteredPayments: signInUser.hasRegisteredPayments, currentRentalId: signInUser.currentRentalId, stampCount: signInUser.stampCount, couponCount: signInUser.couponCount)
                
                self.appState.updateUserState(to: currentUser)
                
            } catch let _ as AuthError {
                //TODO: UseCase에서 로그인 정보 검증 로직 추가 + 검증에 따른 error 처리
                // TODO: 사용자에게 보여줘야하는 에러 처리
            } catch {
                
            }
            
            handleLoading(false)
        }
    }
    
    func dismiss(){
        router.dismissFullScreen()
    }
    
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
    
}
