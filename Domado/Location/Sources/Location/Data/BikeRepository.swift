//
//  LocationRepository.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

// MARK: - Repository
public protocol BikeRepository {
    func fetchBikes(latitude: Double, longitude: Double, radius: Double) async throws -> BikeList
}
