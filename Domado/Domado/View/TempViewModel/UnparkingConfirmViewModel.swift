//
//  UnparkingConfirmViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import SwiftUI

class UnparkingConfirmViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
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

