//
//  File.swift
//  Core
//
//  Created by 이종선 on 11/20/24.
//

import Foundation

public protocol Routing: AnyObject {
    // Navigation
    func navigateTo(_ destination: NavigationDestination)
    func navigateBack()
    func popToRoot()
    
    // Sheet
    func present(sheet: SheetDestination)
    func dismissSheet()
    
    // FullScreen
    func present(fullScreen: FullScreenDestination)
    func dismissFullScreen()
    
}

