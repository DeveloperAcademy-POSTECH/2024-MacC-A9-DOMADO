//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Combine
import Core
import Foundation
import _MapKit_SwiftUI

@MainActor
public class TempLockViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isHiBike: Bool = false
    @Published var isPassed: Bool = false
    @Published var isPaymentProcessing: Bool = false
    @Published var elapsedTime: String = "00:00"
    @Published var homeHub: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 36.012516, longitude: 129.326191)
    
    private let router: Routing
    private let appState: AppState
    private var cancellables = Set<AnyCancellable>()
    
    public init(router: Routing, appState: AppState){
        self.router = router
        self.appState = appState
        
        appState.$elapsedSeconds
            .map { seconds in
                let minutes = seconds / 60
                let remainingSeconds = seconds % 60
                return String(format: "%02d:%02d", minutes, remainingSeconds)
            }
            .assign(to: &$elapsedTime)
        
        appState.$isProcessingPayment
            .sink { [weak self] isProcessing in
                self?.isPaymentProcessing = isProcessing
            }
            .store(in: &cancellables)
    }
    
    public func showUnparkConfirmView(){
        router.present(sheet: .confirmUnParking)
    }
    
    public func showHikeBikeGuide(){
        router.present(sheet: .showHiBikeGuide)
    }

    public func showCompleteHiBike(){
        isPassed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.router.present(sheet: .showHiBikeComplete)
        }
    }

}
