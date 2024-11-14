//
//  Untitled 3.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 대여 상세 정보 DTO
public struct RentalDetail {
   /// 대여 기본 정보
   public let rental: Rental
   /// 대여한 자전거 정보
   public let bike: Bike
   /// 대여/반납 스테이션 정보
   public let station: Station?
   /// 현재까지의 이용 요금 정보
   public let currentCharge: RentalPrice
   
   public init(
       rental: Rental,
       bike: Bike,
       station: Station?,
       currentCharge: RentalPrice
   ) {
       self.rental = rental
       self.bike = bike
       self.station = station
       self.currentCharge = currentCharge
   }
}
