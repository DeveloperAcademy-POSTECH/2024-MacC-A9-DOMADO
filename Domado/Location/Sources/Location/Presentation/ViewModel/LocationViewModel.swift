//
//  LocationViewModel.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Core
import SwiftUI
import _MapKit_SwiftUI

@MainActor
public class LocationViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 36.014109,
            longitude: 129.325666
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02
        )
    )))
    @Published var bikeList: BikeList?
    @Published var selectedHub: Hub?
    @Published var selectedHiBike: HiBike?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let useCase: BikesUseCase
    
    public init(useCase: BikesUseCase) {
        self.useCase = useCase
    }
    
    func fetchBikes(latitude: Double, longitude: Double) {
        
        guard !isLoading else { return }
        
        Task { [weak self, useCase] in
            
            guard let self else { return }
            self.handleLoading(true)
            
            do {
                let result = try await useCase.fetchAllBikes(
                    latitude: latitude,
                    longitude: longitude,
                    radius: 2.0  // 2km 반경으로 기본 설정
                )
                
                await MainActor.run {
                    self.bikeList = result
                    self.error = nil
                    
                    // 첫 로딩 시 지도 위치 업데이트
                    if self.bikeList == nil {
                        self.position = .region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        ))
                    }
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
           self.handleLoading(false)
        }
    }
    
    func selectHub(_ hub: Hub) {
        selectedHub = hub
        selectedHiBike = nil
        updateMapPosition(latitude: hub.latitude, longitude: hub.longitude)
    }
    
    func selectHiBike(_ hiBike: HiBike) {
        selectedHiBike = hiBike
        selectedHub = nil
        updateMapPosition(latitude: hiBike.latitude, longitude: hiBike.longitude)
    }
    
    func clearSelection() {
        selectedHub = nil
        selectedHiBike = nil
    }
    
    func resetToDefaultZoom(center: CLLocationCoordinate2D) {
        position = .region(MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,  // 최대 줌아웃 레벨
                longitudeDelta: 0.1
            )
        ))
    }
    
    private func updateMapPosition(latitude: Double, longitude: Double) {
        position = .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.0015,
                longitudeDelta: 0.0015
            )
        ))
    }
    
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
}
