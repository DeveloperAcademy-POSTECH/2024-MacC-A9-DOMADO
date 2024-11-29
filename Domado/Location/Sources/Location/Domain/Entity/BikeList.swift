//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Foundation

public struct BikeList: Codable, Sendable {
    public let hubs: [Hub]
    public let hiBikes: [HiBike]
    
    public init(hubs: [Hub], hiBikes: [HiBike]) {
        self.hubs = hubs
        self.hiBikes = hiBikes
    }
}
