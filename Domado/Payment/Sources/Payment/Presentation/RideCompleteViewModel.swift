//
//  File.swift
//  Payment
//
//  Created by 이종선 on 11/30/24.
//

import Core
import Foundation

public class RideCompleteViewModel: ObservableObject {
    
    private let router: Routing
    private let appState: AppState
    
    @Published var homeHubName: String = "박태준학술정보관"
    @Published var rideTime: String = "09:27 - 09:41"
    @Published var appliedCoupon: String = ""
    @Published var paymentMethod: String = "기업은행 **79"
    @Published var fareAmount: String = "5,600"
    @Published var rideDuration: String = "30 : 21"
    @Published var rideDistance: String = "13"
    
    public init(router: Routing, appState: AppState) {
        self.router = router
        self.appState = appState
        self.appliedCoupon = appState.isApplyCoupon ? "적용" : "미적용"
        setupRideDetails(elapsedSeconds: appState.elapsedSeconds)
    }
    
    private func setupRideDetails(elapsedSeconds: Int) {
        // Calculate ride duration (초 단위로 표시)
        let minutes = elapsedSeconds / 60
        let seconds = elapsedSeconds % 60
        rideDuration = String(format: "%02d : %02d", minutes, seconds)
        
        // Calculate ride time (start and end time)
        let calendar = Calendar.current
        let endTime = Date()
        let startTime = calendar.date(byAdding: .second, value: -elapsedSeconds, to: endTime)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        rideTime = "\(dateFormatter.string(from: startTime)) - \(dateFormatter.string(from: endTime))"
        
        // Calculate fare amount (기본 요금 100원 + 초당 0.5원)
        let baseAmount = 100.0
        let amountPerSecond = 0.5
        let totalAmount = Int(baseAmount + (Double(elapsedSeconds) * amountPerSecond))
        fareAmount = numberFormatter.string(from: NSNumber(value: totalAmount)) ?? "0"
        
        // Calculate approximate distance (assume average speed of 15km/h)
        let averageSpeedKmH = 15.0
        let hours = Double(elapsedSeconds) / 3600.0
        let distanceKm = averageSpeedKmH * hours
        rideDistance = String(format: "%.1f", distanceKm)
    }
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    func goHomeView() {
        appState.resetTimer()
        router.dismissFullScreen()
        router.popToRoot()
    }
}
