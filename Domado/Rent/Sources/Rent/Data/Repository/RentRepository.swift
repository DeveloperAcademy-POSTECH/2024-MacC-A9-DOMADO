//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

public protocol RentBikeRepository {
    func rentBike(qrCode: String, useCoupon: Bool) async throws -> RentalResponse
}
