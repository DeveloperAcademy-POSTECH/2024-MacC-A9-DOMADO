//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Core 
import Foundation
public final class DefaultRentBikeRepository: RentBikeRepository {
    private let networkManager: CoreNetworkManager
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager as! CoreNetworkManager
    }
    
    public func rentBike(qrCode: String, useCoupon: Bool) async throws -> RentalResponse {
        let queryItems = [
            URLQueryItem(name: "qrCode", value: qrCode),
            URLQueryItem(name: "useCoupon", value: String(useCoupon))
        ]
        
        let endpoint = Endpoint(
            path: "/api/rentals/rent",
            method: .POST,
            queryItems: queryItems
        )
        
        // authenticatedRequest 사용으로 변경
        let response: BaseResponse<RentalResponse> = try await networkManager.authenticatedRequest(endpoint)
        
        guard let rentalResponse = response.data else {
            throw NetworkError.invalidResponse
        }
        
        return rentalResponse
    }
}
