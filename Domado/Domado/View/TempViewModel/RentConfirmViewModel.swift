//
//  RentConfirmViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Foundation

class RentConfirmViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func cancelRent() {
        router.dismissSheet()
    }
    
    func rentBike() {
        router.dismissSheet()
        router.dismissFullScreen()
        router.navigateTo(.inUse)
    }
 
}
