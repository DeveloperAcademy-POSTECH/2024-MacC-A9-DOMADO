//
//  Untitled 6.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 인수인계 요청 수락 DTO
public struct AcceptHandoverRequest {
   /// 수락할 인수인계 요청 ID
   public let handoverId: UUID
   /// 인수인계를 제공하는 사용자 ID
   public let providerId: String
   /// 현재 진행 중인 대여 ID
   public let currentRentalId: UUID
   
   public init(
       handoverId: UUID,
       providerId: String,
       currentRentalId: UUID
   ) {
       self.handoverId = handoverId
       self.providerId = providerId
       self.currentRentalId = currentRentalId
   }
}
