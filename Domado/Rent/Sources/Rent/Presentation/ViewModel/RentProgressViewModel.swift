//
//  RentProgressViewModel.swift
//  Rent
//
//  Created by 고재보 on 11/23/24.
//

import Foundation
import Core

public class RentProgressViewModel: ObservableObject {
    @Published var isApplyCoupon: Bool = false
    /// AppState를 통해 주입
    var bikeId: String = ""
    var stationName: String = ""
    
    private let router: Routing
    
    public init(router: Routing) {
        self.router = router
    }
    
    func startRental() {
        // 여기에 실제 대여 로직 구현
        print("자전거 대여 시작")
        
        // 화면 이동 로직
        router.dismissSheet()
        router.dismissFullScreen()
        router.navigateTo(.inUse)
       
    }
    
    func dismiss() {
        router.dismissSheet()
    }
}


