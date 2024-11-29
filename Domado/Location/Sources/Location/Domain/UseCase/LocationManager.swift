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
    @Published var userLocation: CLLocationCoordinate2D?
    
    public override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.startUpdatingLocation()
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
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            userLocation = location
        }
    }
}
