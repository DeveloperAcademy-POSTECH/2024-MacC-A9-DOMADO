//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Foundation

public struct DockBike: Codable, Identifiable, Sendable {
    public let bikeId: Int
    public let qrCode: String
    public let batteryLevel: Int
    public let status: BikeStatus
    public let hiBikeStatus: HiBikeStatus
    public let currentDockId: Int
    public let homeHubId: Int
    public let homeHubName: String
    
    public var id: Int { bikeId }
    
    public init(bikeId: Int, qrCode: String, batteryLevel: Int, status: BikeStatus, hiBikeStatus: HiBikeStatus, currentDockId: Int, homeHubId: Int, homeHubName: String) {
        self.bikeId = bikeId
        self.qrCode = qrCode
        self.batteryLevel = batteryLevel
        self.status = status
        self.hiBikeStatus = hiBikeStatus
        self.currentDockId = currentDockId
        self.homeHubId = homeHubId
        self.homeHubName = homeHubName
    }
}
