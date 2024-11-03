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
    
    // MARK: 의존성 목록
    
    /// 앱 상태 관리
    private lazy var appState: AppState = {
        AppState()
    }()
    
    /// 화면 계층 관리
    private lazy var router: AppRouter = {
        AppRouter()
    }()
    
    /// 표시될 에러 관리
    private lazy var globalErrorState: GlobalErrorState = {
        GlobalErrorState()
    }()
    
    private lazy var globalErrorHandler: GlobalErrorHandler = {
        AppGlobalErrorHandler(errorState: globalErrorState)
    }()
    
    /// 로깅 서비스
    private var logService: Logger = {
        CoreLogger.shared
    }()
    
    // MARK: 의존성 주입을 위한 팩토리 메서드
    
    /// 앱 상태 의존성 주입
    func makeAppState() -> AppState {
        appState
    }
    
    /// RootView 의존성 주입
    func makeRootDependencies() -> RootDependencies {
        RootDependencies(router: router, globalErrorState: globalErrorState, globalErrorHandler: globalErrorHandler)
    }
    
}
