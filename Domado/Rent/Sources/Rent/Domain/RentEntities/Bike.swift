//
//  Bike.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct Bike {
    public let id: String          // 자전거 고유 식별자
    public let stationId: String?  // 현재 위치한 스테이션
    public let status: BikeStatus  // 자전거 상태
    public let lastCheckedAt: Date // 마지막 점검 시간
    public let qrCode: QRCode?     // QR 코드 정보
    
    public init(
        id: String,
        stationId: String?,
        status: BikeStatus,
        lastCheckedAt: Date = Date(),
        qrCode: QRCode? = nil
    ) {
        self.id = id
        self.stationId = stationId
        self.status = status
        self.lastCheckedAt = lastCheckedAt
        self.qrCode = qrCode
    }
}
