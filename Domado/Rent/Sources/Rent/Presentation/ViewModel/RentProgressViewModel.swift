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

@MainActor
public class RentProgressViewModel: ObservableObject {
    var isApplyCoupon: Bool {
        get { appState.isApplyCoupon }
        set { appState.updateCouponState(newValue) }
    }
    /// AppState를 통해 주입
    var bikeId: String = "301100"
    var stationName: String = "박태준학술정보관"
    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 36.012516, longitude: 129.326191)
    @Published var cameraPosition: MapCameraPosition
    
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
        appState.resetTimer()
    }
    
    func dismiss() {
        router.dismissSheet()
        resetScanningState()
    }
    
    func resetScanningState() {
        // 스캐닝 상태만 리셋
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.appState.doneScanning()
        }
    }
}


