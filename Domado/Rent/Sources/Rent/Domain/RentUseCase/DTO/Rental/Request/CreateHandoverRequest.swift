//
//  Untitled 4.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 인수인계 요청 생성 DTO
public struct CreateHandoverRequest {
   /// 인수인계를 요청하는 사용자 ID
   public let requesterId: String
   /// 인수인계 희망 위치
   public let location: Location
   /// 인수인계 희망 시간
   public let preferredTime: Date
   
   public init(
       requesterId: String,
       location: Location,
       preferredTime: Date
   ) {
       self.requesterId = requesterId
       self.location = location
       self.preferredTime = preferredTime
   }
}
