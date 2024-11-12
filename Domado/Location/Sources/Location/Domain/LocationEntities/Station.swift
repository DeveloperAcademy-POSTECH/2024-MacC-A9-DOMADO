//
//  Station.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Station: Identifiable {
    public let id: String
    public let name: String
    public let coordinate: (latitude: Double, longitude: Double)
    public let bikes: [Bike]
    
    public var availableBikes: Int {
        bikes.filter { $0.isAvailable }.count
    }
    
    public init(id: String,
                   name: String,
                   coordinate: (latitude: Double, longitude: Double),
                   bikes: [Bike]) {
            self.id = id
            self.name = name
            self.coordinate = coordinate
            self.bikes = bikes
        }
}
