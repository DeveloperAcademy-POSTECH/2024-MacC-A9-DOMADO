//
//  Station.swift
//  Rent
//
//  Created by 고재보 on 11/8/24.
//

import Foundation


public struct Station {
    public let id: String          // 스테이션 고유 식별자
    public let name: String        // 스테이션 이름
    public let location: Location  // 스테이션 위치
    public let totalDocks: Int     // 전체 거치대 수
    public let availableBikes: Int // 현재 대여 가능한 자전거 수
    
    public init(
        id: String,
        name: String,
        location: Location,
        totalDocks: Int,
        availableBikes: Int
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.totalDocks = totalDocks
        self.availableBikes = availableBikes
    }
}
