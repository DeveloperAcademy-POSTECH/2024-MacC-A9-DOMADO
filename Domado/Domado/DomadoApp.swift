//
//  DomadoApp.swift
//  Domado
//
//  Created by 이종선 on 9/10/24.
//

import SwiftUI

@main
struct DomadoApp: App {
    private let dIContainer: AppContainer
    @StateObject var appState: AppState
    @UIApplicationDelegateAdaptor(AppDelegateAdapter.self) private var appDelegate
    
    init() {
        let dIContainer = AppContainer()
        self.dIContainer = dIContainer
        _appState = StateObject(wrappedValue: dIContainer.makeAppState())
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(container: dIContainer)
                .environmentObject(appState)
        }
    }
}
