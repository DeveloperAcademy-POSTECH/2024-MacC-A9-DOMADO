//
//  Bike.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Bike: MapDisplayable {
    var coordinate: (latitude: Double, longitude: Double)?
    
    public let id: String
    public let name: String
    public var dockNumber: Int?
    public var isAvailable: Bool
    public var isHiBike: Bool
    public var batteryLevel: Int
    public let hubName: String
    
    public init(coordinate: (latitude: Double, longitude: Double)? = nil, id: String, name: String, dockNumber: Int? = nil, isAvailable: Bool, isHiBike: Bool, batteryLevel: Int, hubName: String) {
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
