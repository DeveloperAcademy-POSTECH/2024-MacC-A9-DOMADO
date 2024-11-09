//
//  Handover.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct Handover {
    public let id: UUID            // 인수인계 고유 식별자
    public let requesterId: String // 요청자 ID
    public let providerId: String? // 제공자 ID
    public let rentalId: UUID?     // 연관된 대여 ID
    public let location: Location  // 인수인계 희망 위치
    public let preferredTime: Date // 희망 시간
    public let status: HandoverStatus // 인수인계 상태
    public let createdAt: Date     // 생성 시간
    
    public init(
        id: UUID = UUID(),
        requesterId: String,
        providerId: String? = nil,
        rentalId: UUID? = nil,
        location: Location,
        preferredTime: Date,
        status: HandoverStatus = .pending,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.requesterId = requesterId
        self.providerId = providerId
        self.rentalId = rentalId
        self.location = location
        self.preferredTime = preferredTime
        self.status = status
        self.createdAt = createdAt
    }
}
