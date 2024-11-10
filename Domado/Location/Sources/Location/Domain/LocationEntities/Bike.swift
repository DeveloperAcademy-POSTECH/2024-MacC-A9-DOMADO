//
//  Bike.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Bike {
    public let id: String
    public let name: String
    public var bikeLocation: Location?
    public var dockNumber: Int?
    public var isAvailable: Bool
    public var isHiBike: Bool
    public var batteryLevel: Int
    public let hubName: String
    
    public init(id: String, name: String, isAvailable: Bool, isHiBike: Bool, batteryLevel: Int, hubName: String, bikeLocation: Location? = nil, dockNumber: Int? = nil) {
        self.id = id
        self.name = name
        self.isAvailable = isAvailable
        self.isHiBike = isHiBike
        self.batteryLevel = batteryLevel
        self.hubName = hubName
        self.bikeLocation = isHiBike ? bikeLocation : nil
        self.dockNumber = isHiBike ? nil : dockNumber
    }
}
