//
//  QuScannerViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Foundation

class QRScannerViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func dismissQRScanner() {
        router.dismissSheet()
    }
}
