//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Core
import Foundation

public struct RentalResponse: Codable, Sendable {
    public let rentalId: Int
    public let bikeId: Int
    public let startTime: String
    public let message: String
    public let bikeStatus: BikeStatus
    public let hiBikeStatus: HiBikeStatus
}
