//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/30/24.
//

import Core
import Foundation

public class HiBikeCompleteViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing){
        self.router = router
    }
    
    func rideComplete(){
        router.dismissSheet()
        router.present(fullScreen: .rideComplete)
    }
}
