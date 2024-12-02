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
    @Published var isApplyCoupon: Bool = false
    /// AppState를 통해 주입
    /// 스캔한 자전거 정보를 저장할 프로퍼티들
    private let bikeData: BikeQRData?
    var bikeId: String
    var stationName: String
    let coordinate: CLLocationCoordinate2D
    @Published var cameraPosition: MapCameraPosition
    
    
    private let router: Routing
    private let appState: AppState
    
    public init(router: Routing, appState: AppState) {
        self.router = router
        self.appState = appState
        
        // AppState에서 스캔한 자전거 정보 가져오기
        self.bikeData = appState.currentScanningBike
        
        // bikeData가 있으면 해당 정보 사용, 없으면 기본값 사용
        self.bikeId = bikeData?.bikeCode ?? "BIKE001"
        self.stationName = bikeData?.homeHub.name ?? "무은재 기념관"
        self.coordinate = bikeData.map {
            CLLocationCoordinate2D(
                latitude: $0.homeHub.location.latitude,
                longitude: $0.homeHub.location.longitude
            )
        } ?? CLLocationCoordinate2D(latitude: 36.012061, longitude: 129.322220)
        
        // 카메라 위치 설정
        self.cameraPosition = .region(MKCoordinateRegion(
            center: self.coordinate,
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
        appState.clearCurrentScanningBike()
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


