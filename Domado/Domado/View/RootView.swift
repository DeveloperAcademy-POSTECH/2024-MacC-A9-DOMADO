//
//  ContentView.swift
//  Domado
//
//  Created by 이종선 on 9/10/24.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var router = AppRouter()
    @EnvironmentObject private var appState : AppState
    
    @StateObject private var globalErrorState: GlobalErrorState
    @StateObject var globalErrorHandler: AppGlobalErrorHandler
    
    // MARK: DI 주입방식으로 교체 예정
    init() {
        let state = GlobalErrorState()
        let handler = AppGlobalErrorHandler(errorState: state)
        
        _globalErrorState = StateObject(wrappedValue: state)
        _globalErrorHandler = StateObject(wrappedValue: handler)
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
                    LoginView()
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
        .environmentObject(router)
        .environmentObject(globalErrorHandler)
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
                QRScannerView()
        }
    }
    
    @ViewBuilder
    private func fullScreenView(for fullScreen: FullScreenDestination) -> some View {
        switch fullScreen {
        case .login:
            LoginView()
        case .onboarding:
            OnboardingView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock AppState with sample data
        let appState = AppState()
        
        return RootView()
            .environmentObject(appState)
    }
}
