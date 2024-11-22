//
//  TempLockViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Foundation


class TempLockViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func showUnparkConfirmView(){
        router.present(sheet: .confirmUnParking)
    }
    
    func showHikeBikeGuide(){
        router.present(sheet: .showHiBikeGuide)
    }

}
