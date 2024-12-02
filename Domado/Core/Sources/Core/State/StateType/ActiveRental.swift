//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Foundation

public struct ActiveRental: Codable {
    
    public init(rentalId: Int, bikeId: Int, startTime: String, bikeStatus: BikeStatus, hiBikeStatus: HiBikeStatus) {
        self.rentalId = rentalId
        self.bikeId = bikeId
        self.startTime = startTime
        self.bikeStatus = bikeStatus
        self.hiBikeStatus = hiBikeStatus
    }
    
    let rentalId: Int
    let bikeId: Int
    let startTime: String
    let bikeStatus: BikeStatus
    let hiBikeStatus: HiBikeStatus
}
