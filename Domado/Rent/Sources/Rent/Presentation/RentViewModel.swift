//
//  Untitled 2.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

import Foundation
import CodeScanner

public class RentViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let onComplete: (QRScanResult) -> Void
    private let onDismiss: () -> Void
    
    public init(
        onComplete: @escaping (QRScanResult) -> Void,
        onDismiss: @escaping () -> Void
    ) {
        self.onComplete = onComplete
        self.onDismiss = onDismiss
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            validateQRCode(result.string)
        case .failure(let error):
            handleError(error)
        }
        showAlert = true
    }
    
    func dismissAlert() {
        showAlert = false
        // 성공적으로 스캔된 경우에만 화면을 닫음
        if case .success = lastResult {
            dismiss()
        }
    }
    
    func dismiss() {
        onDismiss()
    }
    
    private var lastResult: QRScanResult?
    
    private func validateQRCode(_ code: String) {
        // QR 코드 검증 로직
        guard code.hasPrefix("BIKE-") else {
            alertMessage = "유효하지 않은 QR 코드입니다"
            lastResult = .invalidFormat
            onComplete(.invalidFormat)
            return
        }
        
        let bikeId = String(code.dropFirst(5))
        alertMessage = "자전거 확인 완료"
        
        let qrCode = QRCode(
            code: code,
            bikeId: bikeId,
            stationId: "STATION-1", // TODO: 현재 위치한 스테이션 ID를 사용하도록 수정
            type: .rental
        )
        
        lastResult = .success(qrCode)
        onComplete(.success(qrCode))
    }
    
    private func handleError(_ error: ScanError) {
        alertMessage = "스캔 실패: \(error.localizedDescription)"
        lastResult = .unknownError(message: error.localizedDescription)
        onComplete(.unknownError(message: error.localizedDescription))
    }
}
