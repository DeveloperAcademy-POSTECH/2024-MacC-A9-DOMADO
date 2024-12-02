//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/10/24.
//

import Foundation

public protocol RentBikeUseCase {
    func execute(qrCode: String, useCoupon: Bool) async throws -> RentalResponse
}
