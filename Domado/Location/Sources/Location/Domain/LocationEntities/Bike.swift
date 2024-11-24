//
//  Bike.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Bike: MapDisplayable, Identifiable {
    public let id: String
    public let bikeName: String
    public let coordinate: (latitude: Double, longitude: Double)?
    public let dockNumber: Int?
    public let isHiBike: Bool
    public let batteryLevel: Int
    public let homeHubName: String
    
    public var markerType: MarkerType {
        .hiBike(homeHubName: homeHubName)
    }
    
    public init(coordinate: (latitude: Double, longitude: Double)? = nil,
               id: String,
               bikeName: String,
               dockNumber: Int? = nil,
               isHiBike: Bool,
               batteryLevel: Int,
               homeHubName: String) {
        self.coordinate = isHiBike ? coordinate : nil
        self.id = id
        self.bikeName = bikeName
        self.dockNumber = isHiBike ? nil : dockNumber
        self.isHiBike = isHiBike
        self.batteryLevel = batteryLevel
        self.homeHubName = homeHubName
    }
}
