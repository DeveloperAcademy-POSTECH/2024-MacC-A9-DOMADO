//
//  BikeQRData.swift
//  Core
//
//  Created by 이종선 on 12/2/24.
//

import Foundation

public struct BikeQRData: Codable {
    let bikeCode: String
    let homeHub: HomeHub
    
    struct HomeHub: Codable {
        let name: String
        let location: Location
        
        struct Location: Codable {
            let latitude: Double
            let longitude: Double
        }
    }
}
