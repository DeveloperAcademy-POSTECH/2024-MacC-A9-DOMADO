//
//  QuScannerViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/10/24.
//

import Foundation
import Rent

class QRScannerViewModel: ObservableObject {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func dismissQRScanner() {
        router.dismissFullScreen()
    }
    
    func handleScanResult(_ result: QRScanResult) {
            switch result {
            case .success(let qrCode):
                print("스캔 성공: \(qrCode)")
                // TODO: 자전거 대여 프로세스 시작
            case .invalidFormat:
                print("잘못된 QR 코드 형식")
            case .expired:
                print("만료된 QR 코드")
            case .wrongStation(let expected):
                print("잘못된 스테이션: \(expected)")
            case .bikeNotAvailable:
                print("대여 불가능한 자전거")
            case .maintenanceRequired:
                print("정비가 필요한 자전거")
            case .unknownError(let message):
                print("알 수 없는 오류: \(message)")
            }
        }
    }
