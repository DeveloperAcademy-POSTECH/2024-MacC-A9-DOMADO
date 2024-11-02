//
//  DomadoApp.swift
//  Domado
//
//  Created by 이종선 on 9/10/24.
//

import SwiftUI

@main
struct DomadoApp: App {
    @StateObject var appState: AppState = AppState()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
