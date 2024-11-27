//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation

public class ParkingConfirmViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing) {
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
