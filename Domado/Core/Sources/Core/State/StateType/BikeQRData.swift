//
//  BikeQRData.swift
//  Core
//
//  Created by 이종선 on 12/2/24.
//

import Foundation

public struct BikeQRData: Codable {
    public let bikeCode: String
    public let homeHub: HomeHub
    
    public struct HomeHub: Codable {
        public let name: String
        public let location: Location
        
        public struct Location: Codable {
            public let latitude: Double
            public let longitude: Double
        }
    }
}
