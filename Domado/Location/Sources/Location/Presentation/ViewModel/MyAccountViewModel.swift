//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Core
import Foundation

public class MyAccountViewModel: ObservableObject  {
    
    private let router: Routing
    
    public init(router: Routing){
        self.router = router 
    }
    
    func dismiss(){
        router.dismissFullScreen()
    }
}
