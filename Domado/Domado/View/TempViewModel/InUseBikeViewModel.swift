//
//  InUseBikeViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Foundation

class InUseBikeViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func parkBike() {
        router.present(sheet: .confirmParking)
    }
    

}
