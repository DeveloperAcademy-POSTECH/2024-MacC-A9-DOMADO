//
//  Common.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct Location {
    public let latitude: Double    // 위도
    public let longitude: Double   // 경도
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public struct RentalPrice {
    public let baseAmount: Decimal     // 기본 요금
    public let extraAmount: Decimal    // 추가 요금
    public let discountAmount: Decimal // 할인 금액
    public var totalAmount: Decimal {  // 총 요금
        baseAmount + extraAmount - discountAmount
    }
    
    public init(
        baseAmount: Decimal,
        extraAmount: Decimal = 0,
        discountAmount: Decimal = 0
    ) {
        self.baseAmount = baseAmount
        self.extraAmount = extraAmount
        self.discountAmount = discountAmount
    }
}


// MARK: - 상태 및 타입 Enum들

public enum RentalStatus {
    case inProgress  // 대여 진행중
    case completed   // 정상 반납 완료
    case handedOver  // 인수인계 완료
    case overdue     // 시간 초과
}

public enum RentalType {
    case station    // 스테이션에서 대여
    case handover   // 인수인계로 대여
}

public enum BikeStatus {
    case available      // 대여 가능
    case inUse         // 사용중
    case maintenance   // 정비중
    case disabled      // 사용 불가
    case pendingHandover // 인수인계 대기중
}

public enum HandoverStatus {
    case pending    // 대기중
    case accepted   // 수락됨
    case inProgress // 진행중
    case completed  // 완료
    case canceled   // 취소됨
    case expired    // 만료됨
}

public enum QRType {
    case rental      // 대여용
    case unlock      // 잠금해제용
    case maintenance // 정비용
    case handover    // 인수인계용
}

public enum QRScanResult {
    case success(QRCode)
    case invalidFormat
    case expired
    case wrongStation(expected: String)
    case bikeNotAvailable
    case maintenanceRequired
    case unknownError(message: String)
}
