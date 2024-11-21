//
//  AppContainer.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Auth
import Core
import Foundation

/// 앱 전체 의존성을 관리하고 팩토리 메서드를 통해 의존성을 주입합니다.

@MainActor
final class AppContainer {
    
    /// 생성자 내부에서 초기화 순서 명시적 정의
    init(){
        // 1.먼저 에러 처리 시스템 초기화
        self.gloablErrorState = GlobalErrorState()
        self.globalErrorHandler = AppGlobalErrorHandler(errorState: gloablErrorState)
        AppErrorHandler.shared.initialize(errorHandler: globalErrorHandler)
        
        // 2.에러 처리가 필요한 다른 컴포넌트 초기화
        do {
            self.stateStorage = try StateStorage()
        } catch {
            AppErrorHandler.shared.handleError(error)
            self.stateStorage = StateStorage.createFallback()
        }
    }
    
    
    // MARK: - 의존성 목록
    
    /// 1. 가장 먼저 초기화되어야 하는 에러 처리 관련 의존성
    private let gloablErrorState: GlobalErrorState
    private let globalErrorHandler: AppGlobalErrorHandler
    
    /// 2. 에러 처리에 의존성에 의존하는 다른 컴포넌트들
    // 앱 상태 저장소
    private let stateStorage: StateStorage
    // 앱 상태 관리
    private lazy var appState: AppState = { AppState(storage: stateStorage) }()
    
    /// 화면 계층 관리
    private lazy var router: AppRouter = {
        AppRouter()
    }()
    
    /// 로깅 서비스
    private var logService: Logger = {
        CoreLogger.shared
    }()
    
    private lazy var networkManager: NetworkManager = {
        CoreNetworkManager(storage: stateStorage)
    }()
    
    // MARK: - 의존성 주입을 위한 팩토리 메서드
    
    /// 앱 상태 의존성 주입
    func makeAppState() -> AppState {
        appState
    }
        
    // 앱 전역 에러 상태 표시 주입
    func makeGlobalErrorState() -> GlobalErrorState {
        gloablErrorState
    }
    
    // 앱 화면 전환 방법 주입 
    func makeAppRouter() -> AppRouter {
        router
    }
    
    // MARK: - View 반환 메서드
    func makeOnboardingView() -> OnboardingView {
        OnboardingView(vm: self.makeOnboardingViewModel() )
    }
    
    func makeQRScannerView() -> QRScannerView {
        QRScannerView(vm: self.makeQRScannerViewModel())
    }
    
    // MARK: - ViewModel 반환 메서드
    private func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(router: router)
    }
    
    private func makeQRScannerViewModel() -> QRScannerViewModel {
        QRScannerViewModel(router: router)
    }
    
    // MARK: - Auth 모듈 의존성 관리
    
    private func makeAuthRepository() -> AuthRepository {
        return DefaultAuthRepository(networkManager: networkManager as! CoreNetworkManager, logger: logService as! CoreLogger)
    }
    
    private func makeAuthUseCase() -> AuthUseCase {
        return DefaultAuthUseCase(authRepository: makeAuthRepository())
    }
    
    private func makeLoginViewModel() -> LoginViewModel{
        return LoginViewModel(authUseCase: makeAuthUseCase(), appState: appState, router: router)
    }
    
    func makeLoginView() -> LoginView {
        LoginView(vm: makeLoginViewModel())
    }
    
    private func makeSignupViewModel() -> SignUpViewModel{
        return SignUpViewModel(authUseCase: makeAuthUseCase(), router: router)
    }
    
    func makeSignupView() -> SignUpView {
        SignUpView(vm: makeSignupViewModel())
    }

}
