//
//  LocationUseCase.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Foundation

protocol LocationUseCase {
    func fetchHubLocations() throws -> [MapDisplayable]
    func fetchStations(for hubId: String) throws -> [Station]
    func fetchBikeLocation(for bikeId: String) throws -> MapDisplayable
}

