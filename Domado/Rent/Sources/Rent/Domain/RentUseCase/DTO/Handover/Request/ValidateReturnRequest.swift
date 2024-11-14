//
//  ValidateReturnRequest.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 반납 가능 여부 확인 요청 DTO
public struct ValidateReturnRequest {
   /// 현재 대여 정보 ID
   public let rentalId: UUID
   /// 반납하려는 스테이션 ID
   public let stationId: String
   
   public init(rentalId: UUID, stationId: String) {
       self.rentalId = rentalId
       self.stationId = stationId
   }
}
