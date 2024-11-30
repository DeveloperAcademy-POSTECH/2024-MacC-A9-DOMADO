//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Combine
import Core
import Foundation
import _MapKit_SwiftUI

public class ActiveRentViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var remainingTime = "00:00"
    @Published var batteryLevel = "34km"
    @Published var isParked = false
    @Published var isPaymentProcessing = false
    
    private let router: Routing
    private let appState: AppState
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(router: Routing, appState: AppState){
        self.router = router
        self.appState = appState
        
        appState.$isProcessingPayment
            .sink { [weak self] isProcessing in
                self?.isPaymentProcessing = isProcessing
            }
            .store(in: &cancellables)
    }
    
    func parkBike() {
        router.present(sheet: .confirmParking)
    }
    
    func showPaymentGuide(){
        router.present(sheet: .showPaymentGuide)
    }
    
    //TODO: 이후 삭제 
    func dismissSheet(){
        router.dismissSheet()
    }
    
}
