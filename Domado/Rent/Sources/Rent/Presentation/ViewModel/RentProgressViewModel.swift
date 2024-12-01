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
@MainActor
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
    private let appState: AppState
    
    public init(router: Routing, appState: AppState) {
        self.router = router
        self.appState = appState
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
        resetScanningState()
    }
    
    func dismiss() {
        router.dismissSheet()
        resetScanningState()
    }
    
    func resetScanningState() {
        // 스캐닝 상태만 리셋
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.appState.doneScanning()
        }
    }
}


