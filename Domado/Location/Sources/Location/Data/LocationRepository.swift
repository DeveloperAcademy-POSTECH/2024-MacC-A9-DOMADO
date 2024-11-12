//
//  LocationRepository.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Combine

public protocol LocationRepository {
    func fetchLocations() -> AnyPublisher<LocationResponse, Error>
}
