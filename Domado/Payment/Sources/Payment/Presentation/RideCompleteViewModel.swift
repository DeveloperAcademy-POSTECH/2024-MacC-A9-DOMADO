//
//  File.swift
//  Payment
//
//  Created by 이종선 on 11/30/24.
//

import Core
import Foundation

public class RideCompleteViewModel: ObservableObject {
    
    private let router: Routing
    
    public init(router: Routing){
        self.router = router
    }
    
    func goHomeView(){
        router.dismissFullScreen()
        router.popToRoot()
    }
}
