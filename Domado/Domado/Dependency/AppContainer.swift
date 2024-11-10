//
//  AppContainer.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Core
import Foundation

/// 앱 전체 의존성을 관리하고 팩토리 메서드를 통해 의존성을 주입합니다.

class AppContainer {
    
    struct RootDependencies {
        let router: AppRouter
        let globalErrorState: GlobalErrorState
    }
    
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
    
    // MARK: - 의존성 주입을 위한 팩토리 메서드
    
    /// 앱 상태 의존성 주입
    func makeAppState() -> AppState {
        appState
    }
    
    /// RootView 의존성 주입
    func makeRootDependencies() -> RootDependencies {
        RootDependencies(router: router, globalErrorState: gloablErrorState)
    }
    
}
