//
//  Hub.swift
//  Location
//
//  Created by yoomin on 11/8/24.
//

import Foundation

public struct Hub: MapDisplayable {
    var coordinate: (latitude: Double, longitude: Double)?
    
    public let hubID: String
    public let hubName: String
    public let availableBikes: Int
    public let stations: [Station]
    
}
