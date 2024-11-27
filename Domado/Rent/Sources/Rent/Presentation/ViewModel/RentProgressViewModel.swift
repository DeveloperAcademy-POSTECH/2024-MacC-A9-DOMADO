//
//  RentProgressViewModel.swift
//  Rent
//
//  Created by 고재보 on 11/23/24.
//

import Core
import Foundation
import MapKit
import _MapKit_SwiftUI

// MARK: - Location Marker
struct LocationMarker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

public class RentProgressViewModel: ObservableObject {
    @Published var isApplyCoupon: Bool = false
    /// AppState를 통해 주입
    var bikeId: String = "BIKE001"
    var stationName: String = "무은재 기념관"
    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 36.012061, longitude: 129.322220)
    @Published var cameraPosition: MapCameraPosition
    
    var marker: LocationMarker {
        LocationMarker(coordinate: coordinate)
    }
    
    private let router: Routing
    
    public init(router: Routing) {
        self.router = router
        self.cameraPosition = .region(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
    }
    
    func startRental() {
        // 여기에 실제 대여 로직 구현
        print("자전거 대여 시작")
        
        // 화면 이동 로직
        router.dismissSheet()
        router.dismissFullScreen()
        router.navigateTo(.inUse)
       
    }
    
    func dismiss() {
        router.dismissSheet()
    }
}


