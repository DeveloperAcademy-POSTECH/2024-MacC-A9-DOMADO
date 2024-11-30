//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/30/24.
//

import Core
import Foundation

@MainActor
public class HiBikeCompleteViewModel: ObservableObject {
    
    private let router: Routing
    private let appState: AppState
    
    public init(router: Routing, appState: AppState){
        self.router = router
        self.appState = appState
    }
    
    func rideComplete(){
        // MARK: 서버에 결제 요청
        appState.startPaymentProcessing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.appState.donePaymentProcessing()
        }
        
        router.dismissSheet()
        router.present(fullScreen: .rideComplete)
    }
}
