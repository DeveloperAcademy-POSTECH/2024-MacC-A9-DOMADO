//
//  HomeViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Core
import Foundation

class HomeViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func rentBikeWithQR() {
        router.present(fullScreen: .qrScanner)
    }
    
 
}
