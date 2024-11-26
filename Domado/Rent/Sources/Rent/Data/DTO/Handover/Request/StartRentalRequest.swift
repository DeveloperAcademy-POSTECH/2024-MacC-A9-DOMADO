//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 대여 시작 요청 DTO
public struct StartRentalRequest {
   /// 대여할 자전거 ID
   public let bikeId: String
   /// 대여하는 사용자 ID
   public let userId: String
   /// 대여 스테이션 ID
   public let stationId: String
   
   public init(bikeId: String, userId: String, stationId: String) {
       self.bikeId = bikeId
       self.userId = userId
       self.stationId = stationId
   }
}
