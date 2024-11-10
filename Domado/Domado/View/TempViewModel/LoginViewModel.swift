//
//  LoginViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func login() {
        router.navigateTo(.stationDetail)
    }
    
    func qrCodeScan() {
        router.present(sheet: .qrScanner)
    }
    
    func onBoarding() {
        router.present(fullScreen: .onboarding)
    }
    
    
}
