//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Foundation

public struct HiBike: Codable, Identifiable, Sendable {
    public let bikeId: Int
    public let qrCode: String
    public let latitude: Double
    public let longitude: Double
    public let batteryLevel: Int
    public let status: BikeStatus
    public let hiBikeStatus: HiBikeStatus
    public let homeHubId: Int
    public let homeHubName: String
    
    public var id: Int { bikeId }
    
    public init(bikeId: Int, qrCode: String, latitude: Double, longitude: Double, batteryLevel: Int, status: BikeStatus, hiBikeStatus: HiBikeStatus, homeHubId: Int, homeHubName: String) {
        self.bikeId = bikeId
        self.qrCode = qrCode
        self.latitude = latitude
        self.longitude = longitude
        self.batteryLevel = batteryLevel
        self.status = status
        self.hiBikeStatus = hiBikeStatus
        self.homeHubId = homeHubId
        self.homeHubName = homeHubName
    }
}
