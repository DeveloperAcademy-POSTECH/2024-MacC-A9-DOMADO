//
//  QRcode.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct QRCode {
    public let code: String        // QR 코드 값
    public let bikeId: String      // 연결된 자전거 ID
    public let stationId: String   // 연결된 스테이션 ID
    public let type: QRType        // QR 코드 유형
    public let isValid: Bool       // 유효성 여부
    public let expiredAt: Date?    // 만료 시간
    
    public init(
        code: String,
        bikeId: String,
        stationId: String,
        type: QRType,
        isValid: Bool = true,
        expiredAt: Date? = nil
    ) {
        self.code = code
        self.bikeId = bikeId
        self.stationId = stationId
        self.type = type
        self.isValid = isValid
        self.expiredAt = expiredAt
    }
}
