//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Foundation

// Enums
public enum BikeStatus: String, Codable, Sendable {
    case parked = "PARKED"
    case inUse = "IN_USE"
    case temporaryLocked = "TEMPORARY_LOCKED"
    case maintenance = "MAINTENANCE"
    case lowBattery = "LOW_BATTERY"
    case outOfService = "OUT_OF_SERVICE"
    
    var description: String {
        switch self {
        case .parked: return "주차"
        case .inUse: return "사용중"
        case .temporaryLocked: return "일시잠금"
        case .maintenance: return "정비중"
        case .lowBattery: return "배터리 부족"
        case .outOfService: return "이용 불가"
        }
    }
}
