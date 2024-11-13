//
//  LocationUseCase.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Foundation
import Combine

public protocol LocationUseCase {
    func fetchHubLocations() -> AnyPublisher<[MapDisplayable], Error>
    func fetchStations(for hubId: String) -> AnyPublisher<[Station], Error>
    func fetchBikeLocation(for bikeId: String) -> AnyPublisher<MapDisplayable, Error>
}
