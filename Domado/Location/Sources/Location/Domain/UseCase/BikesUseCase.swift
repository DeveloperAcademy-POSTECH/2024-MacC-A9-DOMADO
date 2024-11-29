//
//  LocationUseCase.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Foundation

public protocol BikesUseCase {
    func fetchAllBikes(latitude: Double, longitude: Double, radius: Double) async throws -> BikeList
}
