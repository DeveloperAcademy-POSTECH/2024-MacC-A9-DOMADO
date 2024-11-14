//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/10/24.
//

import Foundation


public protocol RentUseCase {
    // MARK: - QR 스캔 및 대여 시작
    /// QR 코드 스캔 및 검증
    func scanBikeQR(request: QRScanRequest) async throws -> QRScanResult
    
    /// 자전거 대여 시작
    func startRental(request: StartRentalRequest) async throws -> Rental
    
    // MARK: - 대여 상태 관리
    /// 현재 진행 중인 대여 조회
    func getCurrentRental(userId: String) async throws -> Rental?
    
    /// 대여 상세 정보 조회
    func getRentalDetail(rentalId: UUID) async throws -> RentalDetail
    
    // MARK: - 반납 처리
    /// 반납 가능 여부 확인
    func validateReturn(request: ValidateReturnRequest) async throws -> ValidateReturnResult
    
    /// 반납 완료 처리
    func completeReturn(request: CompleteReturnRequest) async throws -> Rental
    
    // MARK: - 인수인계
    /// 인수인계 요청 생성
    func createHandoverRequest(request: CreateHandoverRequest) async throws -> Handover
    
    /// 주변 인수인계 요청 검색
    func searchHandoverRequests(request: SearchHandoverRequest) async throws -> [Handover]
    
    /// 인수인계 요청 수락
    func acceptHandover(request: AcceptHandoverRequest) async throws -> Handover
    
    /// 인수인계 완료
    func completeHandover(request: CompleteHandoverRequest) async throws -> HandoverResult
}
