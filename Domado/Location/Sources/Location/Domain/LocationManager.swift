//
//  LocationManager.swift
//  Location
//
//  Created by 이종선 on 11/27/24.
//

import CoreLocation

public final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    
    public override init() {
        super.init()
        manager.delegate = self
    }
    
    public func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
