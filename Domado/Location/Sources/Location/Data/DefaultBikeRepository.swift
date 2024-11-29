//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Core
import Foundation

public class DefaultBikeRepository: BikeRepository {
    private let networkManager: NetworkManager
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func fetchBikes(latitude: Double, longitude: Double, radius: Double) async throws -> BikeList {
        let endpoint = Endpoint(
            path: "/api/locations/bikes",
            method: .GET,
            queryItems: [
                URLQueryItem(name: "latitude", value: String(latitude)),
                URLQueryItem(name: "longitude", value: String(longitude)),
                URLQueryItem(name: "radius", value: String(radius))
            ]
        )
        
        let response: BaseResponse<BikeList> = try await networkManager.request(endpoint)
        guard let entity = response.data else {
            throw NetworkError.invalidResponse
        }
        return entity
    }
}
