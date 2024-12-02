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
    @Published var isLoading: Bool = false
    /// AppState를 통해 주입
    /// 스캔한 자전거 정보를 저장할 프로퍼티들
    private let bikeData: BikeQRData?
    var bikeId: String
    var stationName: String
    let coordinate: CLLocationCoordinate2D
    @Published var cameraPosition: MapCameraPosition
    
    
    private let router: Routing
    private let appState: AppState
    private let rentBikeUseCase: RentBikeUseCase
    
    public init(router: Routing, appState: AppState, rentBikeUseCase: RentBikeUseCase) {
        self.router = router
        self.appState = appState
        self.rentBikeUseCase = rentBikeUseCase
        
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
    
    // MARK: - Public Methods
    func startRental() {
        guard !isLoading else { return }
        
        Task {[weak self, rentBikeUseCase] in
            guard let self else { return }
            self.handleLoading(true)
            
            do {
                let response = try await rentBikeUseCase.execute(
                    qrCode: bikeId,
                    useCoupon: isApplyCoupon
                )
                
                if response.bikeStatus == .inUse {
                    handleSuccessfulRental()
                } else {
                    // 실패한 경우 처리
                    throw NetworkError.serverError(
                        statusCode: 400,
                        message: "자전거를 현재 대여할 수 없습니다."
                    )
                }
            } catch {
                self.handleLoading(false)
                // 에러 메시지를 사용자에게 보여주는 로직 추가
                print("대여 실패: \(error)")
            }
        }
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
    
    // MARK: - Private Methods
    private func handleSuccessfulRental() {
        self.isLoading = false  // 로딩 상태 즉시 해제
        router.dismissSheet()
        router.dismissFullScreen()
        router.navigateTo(.inUse)
    }
    
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
}


