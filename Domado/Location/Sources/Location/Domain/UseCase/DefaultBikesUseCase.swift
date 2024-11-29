//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import Foundation

public class DefaultBikesUseCase: BikesUseCase {
    private let repository: BikeRepository
    
    public init(repository: BikeRepository) {
        self.repository = repository
    }
    
    public func fetchAllBikes(latitude: Double, longitude: Double, radius: Double) async throws -> BikeList {
        try await repository.fetchBikes(latitude: latitude, longitude: longitude, radius: radius)
    }
}
