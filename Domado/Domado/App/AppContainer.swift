//
//  AppContainer.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Auth
import Core
import Foundation
import Rent 

/// 앱 전체 의존성을 관리하고 팩토리 메서드를 통해 의존성을 주입합니다.

@MainActor
final class AppContainer {
    
    // MARK: - Shared Instance
    static let shared = AppContainer()
    
    /// 생성자 내부에서 초기화 순서 명시적 정의
    private init() {
        // 1. 먼저 에러 처리 시스템 초기화
        self.gloablErrorState = GlobalErrorState()
        self.globalErrorHandler = AppGlobalErrorHandler(errorState: gloablErrorState)
        AppErrorHandler.shared.initialize(errorHandler: globalErrorHandler)
        
        // 2. 에러 처리가 필요한 다른 컴포넌트 초기화
        do {
            self.stateStorage = try StateStorage()
        } catch {
            AppErrorHandler.shared.handleError(error)
            self.stateStorage = StateStorage.createFallback()
        }
        
        // 3. 기본 서비스 초기화
        self.logService = CoreLogger.shared
        self.networkManager = CoreNetworkManager(storage: stateStorage)
        self.webSocketManager = WebSocketManager(storage: stateStorage)
        
        // 4. Push Notification Manager 초기화
        self.pushNotificationManager = PushNotificationManager(
            storage: stateStorage,
            logger: logService as! CoreLogger,
            networkManager: networkManager as! CoreNetworkManager
        )
    }
    
    
    // MARK: - 의존성 목록
    private let gloablErrorState: GlobalErrorState
    private let globalErrorHandler: AppGlobalErrorHandler
    private let stateStorage: StateStorage
    private let logService: Logger
    private let networkManager: NetworkManager
    private let webSocketManager: WebSocketManager
    private let pushNotificationManager: PushNotificationManager
    
    private lazy var appState: AppState = { AppState(storage: stateStorage) }()
    private lazy var router: AppRouter = { AppRouter() }()
    
    // MARK: - 의존성 주입을 위한 팩토리 메서드
    func makeAppState() -> AppState { appState }
    func makeGlobalErrorState() -> GlobalErrorState { gloablErrorState }
    func makeAppRouter() -> AppRouter { router }
    func makePushNotificationManager() -> PushNotificationManager { pushNotificationManager }
    
    
    // MARK: - View 반환 메서드
    func makeOnboardingView() -> OnboardingView {
        OnboardingView(vm: self.makeOnboardingViewModel() )
    }
    
    
    // MARK: - ViewModel 반환 메서드
    private func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(router: router)
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
    
    // MARK: - MAP 의존성 관리
    private func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(router: router, appState: makeAppState(), webSocketManager: webSocketManager, pushNotificationManager: makePushNotificationManager())
    }
    
    func makeHomeView() -> HomeView {
        HomeView(vm: self.makeHomeViewModel())
    }
    
    
    // MARK: - Rent 의존성 관리
    private func makeRentViewModel() -> RentViewModel {
        return RentViewModel(router: makeAppRouter(), appState: makeAppState())
    }
    
    func makeRentView() -> RentView {
        RentView(viewModel: makeRentViewModel())
    }
    
    private func makeRentProgressViewModel() -> RentProgressViewModel {
        return RentProgressViewModel(router: makeAppRouter())
    }
    
    func makeRentProgressView() -> RentProgressView {
        RentProgressView(viewModel: makeRentProgressViewModel())
    }
    
    private func makeInUserBikeViewModel() -> InUseBikeViewModel {
        return InUseBikeViewModel(router: router)
    }
    
    func makeInUserBikeView() -> InUseBikeView {
        InUseBikeView(vm: self.makeInUserBikeViewModel())
    }
    
    private func makeParkingConfirmViewModel() -> ParkingConfirmViewModel {
        return ParkingConfirmViewModel(router: router)
    }
    
    func makeParkingConfirmView() -> ParkingConfirmView {
        ParkingConfirmView(vm: self.makeParkingConfirmViewModel())
    }
    
    private func makeTempLockViewModel() -> TempLockViewModel {
        return TempLockViewModel(router: router)
    }
    
    func makeTempLockView() -> TempLockView {
        TempLockView(vm: self.makeTempLockViewModel())
    }
    
    private func makeHiBikeGuideViewModel() -> HiBikeGuideViewModel {
        return HiBikeGuideViewModel(router: router)
    }
    
    func makeHiBikeGuideView() -> HiBikeGuideView {
        HiBikeGuideView(vm: self.makeHiBikeGuideViewModel())
    }
    
    private func makeUnparkingConfirmViewModel() -> UnparkingConfirmViewModel {
        return UnparkingConfirmViewModel(router: router)
    }
    
    func makeUnparkingConfirmView() -> UnparkingConfirmView {
        UnparkingConfirmView(vm: self.makeUnparkingConfirmViewModel())
    }
}
