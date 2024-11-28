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
                case .unauthenticated, .authenticated:
                    container.makeHomeView().navigationBarHidden(true)
                }
            }
            .errorAlert(errorState: globalErrorState)
            .navigationDestination(for: NavigationDestination.self) { destination in
                destinationView(for: destination)
            }
            // QR 스캐너 풀스크린일 때만 그 위에 시트를 보여줌
            .fullScreenCover(item: $router.activeFullScreen) { fullScreen in
                switch fullScreen {
                case .qrScanner:
                    fullScreenView(for: fullScreen)
                        .sheet(item: $router.activeSheet) { sheet in
                            sheetView(for: sheet)
                        }
                default:
                    fullScreenView(for: fullScreen)
                }
            }
            // QR 스캐너가 아닐 때는 여기서 시트를 보여줌
            .sheet(item: $router.activeSheet) { sheet in
                if router.activeFullScreen != .qrScanner {
                    sheetView(for: sheet)
                }
            }
            
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - View Builders
    @ViewBuilder
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .inUse:
            container.makeActiveRentalView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden()
        case .tempLock:
            container.makeTempLockView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden()
        case .returnComplete:
            container.makeTempLockView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden()
        case .singUp:
            container.makeSignupView()
        }
    }
    
    @ViewBuilder
    private func sheetView(for sheet: SheetDestination) -> some View {
        switch sheet {
        case .confirmRent:
            container.makeRentProgressView()
                .presentationDetents([.height(580)])
                .presentationDragIndicator(.visible)
        case .confirmParking:
            container.makeParkingConfirmView()
                .presentationDetents([.height(350)])
        case .showHiBikeGuide:
            container.makeHiBikeGuideView()
                .presentationDetents([.height(350)])
        case .confirmUnParking:
            container.makeUnparkingConfirmView()
                .presentationDetents([.height(350)])
        case .showPaymentGuide: 
            container.makeReturnBikeView()
                .presentationDetents([.height(270)])
        }
    }
    
    @ViewBuilder
    private func fullScreenView(for fullScreen: FullScreenDestination) -> some View {
        switch fullScreen {
        case .login:
            container.makeLoginView()
        case .onboarding:
            container.makeOnboardingView()
        case .qrScanner:
            container.makeRentView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock AppState with sample data
        
        let container = AppContainer.shared
        
        return RootView(container: container)
            .environmentObject(container.makeAppState())
            .environmentObject(container.makeGlobalErrorState())
    }
}
