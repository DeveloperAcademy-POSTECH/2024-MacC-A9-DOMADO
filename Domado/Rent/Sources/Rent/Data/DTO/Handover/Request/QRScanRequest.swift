//
//  QRScanRequest.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// QR 코드 스캔 요청 DTO
public struct QRScanRequest {
   /// 스캔된 QR 코드 문자열
   public let qrCode: String
   /// 현재 사용자가 위치한 스테이션 ID
   public let stationId: String
   
   public init(qrCode: String, stationId: String) {
       self.qrCode = qrCode
       self.stationId = stationId
   }
}
