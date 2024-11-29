//
//  Hub.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Hub: Codable, Identifiable, Sendable {
    public let hubId: Int
    public let hubName: String
    public let latitude: Double
    public let longitude: Double
    public let totalAvailableBikes: Int
    public let stations: [Station]
    
    public var id: Int { hubId }
    
    public init(hubId: Int, hubName: String, latitude: Double, longitude: Double, totalAvailableBikes: Int, stations: [Station]) {
        self.hubId = hubId
        self.hubName = hubName
        self.latitude = latitude
        self.longitude = longitude
        self.totalAvailableBikes = totalAvailableBikes
        self.stations = stations
    }
}
