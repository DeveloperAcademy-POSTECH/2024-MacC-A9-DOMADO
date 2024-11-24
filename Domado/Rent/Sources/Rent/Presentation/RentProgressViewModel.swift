//
//  RentProgressViewModel.swift
//  Rent
//
//  Created by 고재보 on 11/23/24.
//

import Foundation
import Core

public class RentProgressViewModel: ObservableObject {
    @Published var isRental: Bool = false
    @Published var bikeId: String = ""
    @Published var stationName: String = ""
    
    private let onComplete: () -> Void
    private let onDismiss: () -> Void
    
    public init(
        bikeId: String = "",
        stationName: String = "",
        onComplete: @escaping () -> Void,
        onDismiss: @escaping () -> Void
    ) {
        self.bikeId = bikeId
        self.stationName = stationName
        self.onComplete = onComplete
        self.onDismiss = onDismiss
    }
    
    func startRental() {
        // 여기에 실제 대여 로직 구현
        print("자전거 대여 시작")
        onComplete()
    }
    
    func dismiss() {
        onDismiss()
    }
}


