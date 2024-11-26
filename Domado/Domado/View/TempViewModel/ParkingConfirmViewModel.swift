//
//  File.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Foundation

class ParkingConfirmViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func cancelParking() {
        router.dismissSheet()
    }
    
    func parkBike() {
        router.dismissSheet()
        router.navigateTo(.tempLock)
    }
 
}
