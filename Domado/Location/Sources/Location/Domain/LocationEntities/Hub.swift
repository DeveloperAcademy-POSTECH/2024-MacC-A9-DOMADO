//
//  Hub.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Hub: MapDisplayable, Identifiable {
    public let id: String
    public let hubName: String
    public let coordinate: (latitude: Double, longitude: Double)?
    public let availableBikes: Int
    public let stations: [Station]
    
    public var markerType: MarkerType {
        .hub(availableBikes: availableBikes)
    }
    
    public init(id: String,
               hubName: String,
               coordinate: (latitude: Double, longitude: Double)?,
               availableBikes: Int,
               stations: [Station]) {
        self.id = id                
        self.hubName = hubName
        self.coordinate = coordinate
        self.availableBikes = availableBikes
        self.stations = stations
    }

    
}
