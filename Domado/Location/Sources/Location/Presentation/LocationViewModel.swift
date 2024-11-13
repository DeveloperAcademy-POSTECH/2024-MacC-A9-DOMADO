//
//  LocationViewModel.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Foundation
import Combine

/// 위치 정보를 관리하는 ViewModel 클래스
/// MVVM 패턴에서 View와 Model 사이의 중재자 역할을 수행
public final class LocationViewModel: ObservableObject {
    // MARK: - Published Properties (외부에서 관찰 가능한 상태값들)
    /// 지도에 표시될 아이템들 (Hub나 Bike 등)
    @Published private(set) var mapItems: [MapDisplayable] = []
    /// 현재 선택된 지도 아이템
    @Published private(set) var selectedItem: MapDisplayable?
    /// 특정 Hub에 속한 Station들의 목록
    @Published private(set) var stations: [Station] = []
    /// 데이터 로딩 상태를 나타내는 플래그
    @Published private(set) var isLoading: Bool = false
    /// 발생한 에러 정보를 저장
    @Published private(set) var error: Error?
    
    // MARK: - Computed Properties (계산 속성들)
    /// 현재 선택된 아이템이 Hub인 경우 반환
    var selectedHub: Hub? {
        selectedItem as? Hub
    }
    
    /// 현재 선택된 아이템이 Bike인 경우 반환
    var selectedHiBike: Bike? {
        selectedItem as? Bike
    }
    
    // MARK: - Private Properties (내부 구현에 필요한 속성들)
    /// 위치 정보 관련 비즈니스 로직을 처리하는 UseCase
    private let locationUseCase: LocationUseCase
    /// Combine 구독을 관리하기 위한 저장소
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization (초기화)
    public init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
        setupInitialBindings()
    }
    
    // MARK: - Private Methods (내부 구현 메소드들)
    /// 초기 데이터 바인딩 설정
    private func setupInitialBindings() {
        fetchMapItems()
    }
    
    /// 지도에 표시될 아이템들을 서버로부터 가져오는 메소드
    private func fetchMapItems() {
        isLoading = true
        error = nil
        
        locationUseCase.fetchHubLocations()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] items in
                    self?.mapItems = items
                }
            )
            .store(in: &cancellables)
    }
    
    /// 특정 Hub에 속한 Station 정보를 가져오는 메소드
    private func fetchStationsForHub(_ hubId: String) {
        isLoading = true
        error = nil
        
        locationUseCase.fetchStations(for: hubId)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
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
    
    // MARK: - Public Methods (외부에서 호출 가능한 메소드들)
    
    /// 지도 아이템 선택 시 호출되는 메소드
    /// - Parameter item: 선택된 MapDisplayable 아이템
    func selectMapItem(_ item: MapDisplayable?) {
        selectedItem = item
        stations = []
        
        // Hub가 선택된 경우 해당 Hub의 Station 정보를 가져옴
        if let hub = item as? Hub {
            fetchStationsForHub(hub.id)
        }
    }
    
    /// 지도 데이터를 새로고침하는 메소드
    func refreshMapItems() {
        fetchMapItems()
    }
    
    /// 현재 선택된 아이템을 해제하는 메소드
    func clearSelection() {
        selectedItem = nil
        stations = []
    }
    
    /// 발생한 에러를 초기화하는 메소드
    func clearError() {
        error = nil
    }
}

// MARK: - View State Helper (View 상태 관리를 위한 확장)
extension LocationViewModel {
    /// View에서 사용할 상태값들을 포함하는 구조체
    struct ViewState {
        /// Hub 상세 정보를 보여줄지 여부
        let isShowingHubDetail: Bool
        /// Bike 상세 정보를 보여줄지 여부
        let isShowingHiBikeDetail: Bool
        /// 데이터 로딩 중인지 여부
        let isLoading: Bool
        /// 에러가 발생했는지 여부
        let hasError: Bool
        
        /// ViewModel의 상태를 기반으로 ViewState를 초기화
        init(viewModel: LocationViewModel) {
            self.isShowingHubDetail = viewModel.selectedHub != nil
            self.isShowingHiBikeDetail = viewModel.selectedHiBike != nil
            self.isLoading = viewModel.isLoading
            self.hasError = viewModel.error != nil
        }
    }
    
    /// 현재 ViewModel의 상태를 기반으로 ViewState를 생성하는 계산 속성
    var viewState: ViewState {
        ViewState(viewModel: self)
    }
}
