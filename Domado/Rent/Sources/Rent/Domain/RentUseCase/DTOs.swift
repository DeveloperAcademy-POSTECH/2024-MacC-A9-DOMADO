//
//  DTOs.swift
//  Rent
//
//  Created by 고재보 on 11/10/24.
//

import Foundation


public struct QRScanRequest {
    public let qrCode: String
    public let stationId: String
    
    public init(qrCode: String, stationId: String) {
        self.qrCode = qrCode
        self.stationId = stationId
    }
}

public struct StartRentalRequest {
    public let bikeId: String
    public let userId: String
    public let stationId: String
    
    public init(bikeId: String, userId: String, stationId: String) {
        self.bikeId = bikeId
        self.userId = userId
        self.stationId = stationId
    }
}

public struct ValidateReturnRequest {
    public let rentalId: UUID
    public let stationId: String
    
    public init(rentalId: UUID, stationId: String) {
        self.rentalId = rentalId
        self.stationId = stationId
    }
}

public struct CompleteReturnRequest {
    public let rentalId: UUID
    public let stationId: String
    public let endTime: Date
    
    public init(
        rentalId: UUID,
        stationId: String,
        endTime: Date = Date()
    ) {
        self.rentalId = rentalId
        self.stationId = stationId
        self.endTime = endTime
    }
}

public struct CreateHandoverRequest {
    public let requesterId: String
    public let location: Location
    public let preferredTime: Date
    
    public init(
        requesterId: String,
        location: Location,
        preferredTime: Date
    ) {
        self.requesterId = requesterId
        self.location = location
        self.preferredTime = preferredTime
    }
}

public struct SearchHandoverRequest {
    public let latitude: Double
    public let longitude: Double
    public let radius: Double
    
    public init(
        latitude: Double,
        longitude: Double,
        radius: Double
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
    }
}

public struct AcceptHandoverRequest {
    public let handoverId: UUID
    public let providerId: String
    public let currentRentalId: UUID
    
    public init(
        handoverId: UUID,
        providerId: String,
        currentRentalId: UUID
    ) {
        self.handoverId = handoverId
        self.providerId = providerId
        self.currentRentalId = currentRentalId
    }
}

public struct CompleteHandoverRequest {
    public let handoverId: UUID
    public let newUserId: String
    public let location: Location
    
    public init(
        handoverId: UUID,
        newUserId: String,
        location: Location
    ) {
        self.handoverId = handoverId
        self.newUserId = newUserId
        self.location = location
    }
}

public struct ValidateReturnResult {
    public let canReturn: Bool
    public let message: String?
    
    public init(canReturn: Bool, message: String? = nil) {
        self.canReturn = canReturn
        self.message = message
    }
}

public struct HandoverResult {
    public let originalRental: Rental
    public let newRental: Rental
    public let handover: Handover
    
    public init(
        originalRental: Rental,
        newRental: Rental,
        handover: Handover
    ) {
        self.originalRental = originalRental
        self.newRental = newRental
        self.handover = handover
    }
}

public struct RentalDetail {
    public let rental: Rental
    public let bike: Bike
    public let station: Station?
    public let currentCharge: RentalPrice
    
    public init(
        rental: Rental,
        bike: Bike,
        station: Station?,
        currentCharge: RentalPrice
    ) {
        self.rental = rental
        self.bike = bike
        self.station = station
        self.currentCharge = currentCharge
    }
}
