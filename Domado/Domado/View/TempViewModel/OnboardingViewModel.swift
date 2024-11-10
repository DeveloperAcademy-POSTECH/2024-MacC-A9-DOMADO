//
//  OnboardingViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func dismissOnboarding() {
        router.dismissFullScreen()
    }
}
