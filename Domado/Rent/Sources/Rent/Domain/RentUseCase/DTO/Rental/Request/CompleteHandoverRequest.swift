//
//  CompleteHandoverRequest.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 인수인계 완료 요청 DTO
public struct CompleteHandoverRequest {
   /// 완료할 인수인계 요청 ID
   public let handoverId: UUID
   /// 자전거를 인수받는 새로운 사용자 ID
   public let newUserId: String
   /// 인수인계가 완료된 위치
   public let location: Location
   
   public init(
       handoverId: UUID,
       newUserId: String,
       location: Location
   ) {
       self.handoverId = handoverId
       self.newUserId = newUserId
       self.location = location
   }
}
