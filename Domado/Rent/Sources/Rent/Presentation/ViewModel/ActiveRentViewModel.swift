//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation
import _MapKit_SwiftUI

public class ActiveRentViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var remainingTime = "00:00"
    @Published var batteryLevel = "34km"
    @Published var isParked = false
    
    private let router: Routing
    
    public init(router: Routing){
        self.router = router 
    }
    
    func parkBike() {
        router.present(sheet: .confirmParking)
    }
    
}
