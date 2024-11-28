//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation

public class UnparkingConfirmViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing) {
        self.router = router
    }
    
    func dismissUnparkConfirmView(){
        router.dismissSheet()
    }
    
    func unparkBike(){
        router.dismissSheet()
        router.navigateBack()
    }
}

