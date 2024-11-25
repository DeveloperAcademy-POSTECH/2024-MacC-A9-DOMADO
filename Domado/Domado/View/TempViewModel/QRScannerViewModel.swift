//
//  QuScannerViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Core 
import Foundation
import Rent

class QRScannerViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func dismissQRScanner() {
        router.dismissFullScreen()
    }
    
    func handleScanResult() {
        router.present(sheet: .confirmRent)
    }
}
