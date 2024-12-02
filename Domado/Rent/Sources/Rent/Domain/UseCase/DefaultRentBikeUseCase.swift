//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Core 
import Foundation

public final class DefaultRentBikeUseCase: RentBikeUseCase {
    private let repository: RentBikeRepository
    private let appState: AppState
    
    public init(repository: RentBikeRepository, appState: AppState) {
        self.repository = repository
        self.appState = appState
    }
    
    public func execute(qrCode: String, useCoupon: Bool) async throws -> RentalResponse {
        let response = try await repository.rentBike(qrCode: qrCode, useCoupon: useCoupon)
        
        // 대여 성공 시 상태 저장
        if response.bikeStatus == BikeStatus.inUse {
            let activeRental = ActiveRental(
                rentalId: response.rentalId,
                bikeId: response.bikeId,
                startTime: response.startTime,
                bikeStatus: response.bikeStatus,
                hiBikeStatus: response.hiBikeStatus
            )
            
            // AppState를 통해 주행 상태 업데이트
            appState.startRental(activeRental)
        }
        
        return response
    }
}
