//
//  ContentView.swift
//  Domado
//
//  Created by 이종선 on 9/10/24.
//

import SwiftUI
import Core

struct RootView: View {
    
    @StateObject private var router: AppRouter

    @EnvironmentObject private var appState : AppState
    @EnvironmentObject private var globalErrorState: GlobalErrorState
    
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
        _router = StateObject(wrappedValue: container.makeAppRouter())
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch appState.authState {
                case .unknown:
                    LoadingView()
                case .authenticated:
                    HomeView()
                case .unauthenticated:
                    container.makeLoginView()
                }
            }
            .errorAlert(errorState: globalErrorState)
            .navigationDestination(for: NavigationDestination.self) { destination in
                destinationView(for: destination)
            }
            .sheet(item: $router.activeSheet) { sheet in
                sheetView(for: sheet)
            }
            .fullScreenCover(item: $router.activeFullScreen) { fullScreen in
                fullScreenView(for: fullScreen)
            }
            
        }
    }
    
    // MARK: - View Builders
    @ViewBuilder
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .stationDetail:
            StationDetailView()
        case .inUse:
            InUseBikeView()
        case .tempLock:
            TempLockView()
        case .returnComplete:
            ReturnBikeView()
        }
    }
    
    @ViewBuilder
    private func sheetView(for sheet: SheetDestination) -> some View {
        switch sheet {
            case .qrScanner:
            container.makeQRScannerView()
        }
    }
    
    @ViewBuilder
    private func fullScreenView(for fullScreen: FullScreenDestination) -> some View {
        switch fullScreen {
        case .login:
            container.makeLoginView()
        case .onboarding:
            container.makeOnboardingView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock AppState with sample data
        
        let container = AppContainer()
        
        return RootView(container: container)
            .environmentObject(container.makeAppState())
            .environmentObject(container.makeGlobalErrorState())
    }
}
