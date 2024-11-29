//
//  Station.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Station: Codable, Identifiable, Sendable {
    public let stationId: Int
    public let stationName: String
    public let latitude: Double
    public let longitude: Double
    public let capacity: Int
    public let availableBikes: [DockBike]
    
    public var id: Int { stationId }
    
    public init(stationId: Int, stationName: String, latitude: Double, longitude: Double, capacity: Int, availableBikes: [DockBike]) {
        self.stationId = stationId
        self.stationName = stationName
        self.latitude = latitude
        self.longitude = longitude
        self.capacity = capacity
        self.availableBikes = availableBikes
    }
}
