//
//  DomadoApp.swift
//  Domado
//
//  Created by 이종선 on 9/10/24.
//

import SwiftUI
import Core 

@main
struct DomadoApp: App {
    private let dIContainer: AppContainer
    @StateObject var appState: AppState
    @StateObject private var globalErrorState: GlobalErrorState
    @UIApplicationDelegateAdaptor(AppDelegateAdapter.self) private var appDelegate
    
    init() {
        let dIContainer = AppContainer.shared
        self.dIContainer = dIContainer
        _appState = StateObject(wrappedValue: dIContainer.makeAppState())
        _globalErrorState = StateObject(wrappedValue: dIContainer.makeGlobalErrorState())
        
        // AppDelegate에 PushNotificationManager 설정
        appDelegate.setPushNotificationManager(dIContainer.makePushNotificationManager())
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(container: dIContainer)
                .environmentObject(appState)
                .environmentObject(globalErrorState)
                .task {
                    // 앱 실행 시 권한 요청
                    await AppContainer.shared.makePushNotificationManager().requestAuthorization()
                }
            
        }
    }
}
