//
//  Bike.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Bike: MapDisplayable, Identifiable {
    public let id: String
    public let name: String
    public let coordinate: (latitude: Double, longitude: Double)?
    public let dockNumber: Int?
    public let isAvailable: Bool
    public let isHiBike: Bool
    public let batteryLevel: Int
    public let hubName: String
    
    public var markerType: MarkerType {
        .hiBike(batteryLevel: batteryLevel)
    }
    
    public var title: String {
        name
    }
    
    public init(coordinate: (latitude: Double, longitude: Double)? = nil,
               id: String,
               name: String,
               dockNumber: Int? = nil,
               isAvailable: Bool,
               isHiBike: Bool,
               batteryLevel: Int,
               hubName: String) {
        self.coordinate = isHiBike ? coordinate : nil
        self.id = id
        self.name = name
        self.dockNumber = isHiBike ? nil : dockNumber
        self.isAvailable = isAvailable
        self.isHiBike = isHiBike
        self.batteryLevel = batteryLevel
        self.hubName = hubName
    }
}
