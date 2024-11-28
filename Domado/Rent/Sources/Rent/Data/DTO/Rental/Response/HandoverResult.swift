//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 인수인계 완료 결과 DTO
public struct HandoverResult {
   /// 원래 대여 정보 (인수인계 제공자)
   public let originalRental: Rental
   /// 새로운 대여 정보 (인수인계 요청자)
   public let newRental: Rental
   /// 완료된 인수인계 정보
   public let handover: Handover
   
   public init(
       originalRental: Rental,
       newRental: Rental,
       handover: Handover
   ) {
       self.originalRental = originalRental
       self.newRental = newRental
       self.handover = handover
   }
}
