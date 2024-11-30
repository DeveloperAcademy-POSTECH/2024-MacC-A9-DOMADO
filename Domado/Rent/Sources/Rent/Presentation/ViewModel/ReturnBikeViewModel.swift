//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/28/24.
//

import Core
import Foundation

public class ReturnBikeViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing){
        self.router = router
    }
    
    public func rideComplete(){
        router.dismissSheet()
        router.present(fullScreen: .rideComplete)
    }
}
