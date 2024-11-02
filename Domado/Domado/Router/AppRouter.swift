//
//  AppRouter.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var activeSheet: SheetDestination?
    @Published var activeFullScreen: FullScreenDestination?
    
    // Navigation Methods
    func navigateTo(_ destination: NavigationDestination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: SheetDestination) {
        activeSheet = sheet
    }
    
    func present(fullScreen: FullScreenDestination) {
        activeFullScreen = fullScreen
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
    
    func dismissFullScreen() {
        activeFullScreen = nil
    }
}
