//
//  Rental.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct Rental {
    public let id: UUID            // 대여 고유 식별자
    public let bikeId: String      // 자전거 식별자
    public let userId: String      // 사용자 식별자
    public let startStationId: String?  // 대여 시작 스테이션 (인수인계시 nil)
    public let startTime: Date     // 대여 시작 시간
    public let endTime: Date?      // 대여 종료 시간
    public let status: RentalStatus    // 대여 상태
    public let type: RentalType        // 대여 유형(스테이션/인수인계)
    public let handoverId: UUID?       // 인수인계 식별자
    public let currentLocation: Location?  // 현재 위치(인수인계시 필요)
    public let price: RentalPrice?     // 대여 요금 정보
    
    public init(
        id: UUID = UUID(),
        bikeId: String,
        userId: String,
        startStationId: String?,
        startTime: Date = Date(),
        endTime: Date? = nil,
        status: RentalStatus = .inProgress,
        type: RentalType = .station,
        handoverId: UUID? = nil,
        currentLocation: Location? = nil,
        price: RentalPrice? = nil
    ) {
        self.id = id
        self.bikeId = bikeId
        self.userId = userId
        self.startStationId = startStationId
        self.startTime = startTime
        self.endTime = endTime
        self.status = status
        self.type = type
        self.handoverId = handoverId
        self.currentLocation = currentLocation
        self.price = price
    }
}
