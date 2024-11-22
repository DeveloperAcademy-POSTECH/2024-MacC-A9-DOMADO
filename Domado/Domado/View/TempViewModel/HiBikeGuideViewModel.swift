//
//  HiBikeGuideViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Foundation

class HiBikeGuideViewModel: ObservableObject {
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func dismissGuide() {
        router.dismissSheet()
    }
    
}
