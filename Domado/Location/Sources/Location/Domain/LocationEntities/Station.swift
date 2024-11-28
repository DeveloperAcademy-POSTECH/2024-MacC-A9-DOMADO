//
//  Station.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Station: Identifiable {
    public let id: String
    public let stationName: String
    public let bikes: [Bike]
    
    public var availableBikes: Int {
        bikes.count
    }
    
    public init(id: String,
                stationName: String,
                bikes: [Bike]) {
        self.id = id
        self.stationName = stationName
        self.bikes = bikes
    }
}
