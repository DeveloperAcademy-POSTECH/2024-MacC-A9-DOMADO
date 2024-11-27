//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 반납 완료 요청 DTO
public struct CompleteReturnRequest {
   /// 대여 정보 ID
   public let rentalId: UUID
   /// 반납 스테이션 ID
   public let stationId: String
   /// 반납 완료 시간
   public let endTime: Date
   
   public init(
       rentalId: UUID,
       stationId: String,
       endTime: Date = Date()
   ) {
       self.rentalId = rentalId
       self.stationId = stationId
       self.endTime = endTime
   }
}
