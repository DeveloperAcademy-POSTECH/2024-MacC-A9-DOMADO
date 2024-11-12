//
//  DTOs.swift
//  Rent
//
//  Created by 고재보 on 11/10/24.
//

import Foundation


/// 공유 자전거 서비스의 DTO(Data Transfer Object) 정의
/// 각 UseCase의 입출력 데이터 구조를 정의합니다.

// MARK: - QR 스캔 및 대여 시작 관련 DTO
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

// MARK: - 반납 관련 DTO
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

// MARK: - 인수인계 관련 DTO
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

// MARK: - 결과 DTO
/// 반납 가능 여부 확인 결과 DTO
public struct ValidateReturnResult {
   /// 반납 가능 여부
   public let canReturn: Bool
   /// 반납 불가능한 경우의 메시지
   public let message: String?
   
   public init(canReturn: Bool, message: String? = nil) {
       self.canReturn = canReturn
       self.message = message
   }
}

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
