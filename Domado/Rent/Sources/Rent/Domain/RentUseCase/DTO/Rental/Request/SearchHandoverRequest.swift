//
//  Untitled 5.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 주변 인수인계 요청 검색 DTO
public struct SearchHandoverRequest {
   /// 검색 기준 위도
   public let latitude: Double
   /// 검색 기준 경도
   public let longitude: Double
   /// 검색 반경 (미터)
   public let radius: Double
   
   public init(
       latitude: Double,
       longitude: Double,
       radius: Double
   ) {
       self.latitude = latitude
       self.longitude = longitude
       self.radius = radius
   }
}
