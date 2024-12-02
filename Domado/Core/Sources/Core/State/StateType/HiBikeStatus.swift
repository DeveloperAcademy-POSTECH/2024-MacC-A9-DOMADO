//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/2/24.
//

import Foundation

public enum HiBikeStatus: String, Codable, Sendable {
    case none = "NONE"
    case availableForRent = "AVAILABLE_FOR_RENT"
    case transferred = "TRANSFERRED"
    
    var description: String {
        switch self {
        case .none: return "HiBike 아님"
        case .availableForRent: return "HiBike 대여 가능"
        case .transferred: return "HiBike 이관 완료"
        }
    }
}
