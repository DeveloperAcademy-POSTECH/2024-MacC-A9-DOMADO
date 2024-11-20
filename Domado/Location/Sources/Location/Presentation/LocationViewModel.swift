//
//  LocationViewModel.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Foundation
import Combine

public class LocationViewModel: ObservableObject {
    
    @Published private(set) var mapItems: [MapDisplayable] = []
    @Published private(set) var selectedItem: MapDisplayable?
    @Published private(set) var stations: [Station] = []
    @Published private(set) var error: Error?
    
    private let locationUseCase: LocationUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }
    
    func fetchLocations() {
        locationUseCase.fetchHubLocations()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] locations in
                    self?.mapItems = locations
                }
            )
            .store(in: &cancellables)
    }
    
    func itemSelected(_ item: MapDisplayable) {
        selectedItem = item
        
        switch item.markerType {
        case .hub:
            guard let hub = item as? Hub else { return }
            fetchStations(hubId: hub.id)
        case .hiBike:
            guard let bike = item as? Bike else { return }
            fetchHiBikeDetail(bikeId: bike.id)
        }
    }
    
    func deselectItem() {
        selectedItem = nil
        stations = []
    }
    
    private func fetchStations(hubId: String) {
        locationUseCase.fetchStations(for: hubId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] stations in
                    self?.stations = stations
                }
            )
            .store(in: &cancellables)
    }
    
    private func fetchHiBikeDetail(bikeId: String) {
        locationUseCase.fetchHiBikeDetail(bikeId: bikeId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] bike in
                    self?.selectedItem = bike
                }
            )
            .store(in: &cancellables)
    }
}
