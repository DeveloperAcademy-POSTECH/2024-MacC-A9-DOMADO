//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/28/24.
//

import Core
import Foundation

public class HiBikeGuideViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing) {
        self.router = router
    }

    func dismissGuide() {
        router.dismissSheet()
    }
    
}
