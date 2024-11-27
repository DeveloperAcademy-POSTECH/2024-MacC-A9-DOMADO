//
//  Untitled 2.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

import Foundation
import Core
import CodeScanner

public class RentViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var isTorchOn = false 
    var alertMessage = ""
    
    //private let rentUseCase: RentUseCase
    private let router: Routing
    private let appState: AppState
    
    public init(/*rentUseCase: RentUseCase,*/
                router: Routing,
                appState: AppState
    ) {
//        self.rentUseCase = rentUseCase
        self.router = router
        self.appState = appState

    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            validateQRCode(result.string)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func validateQRCode(_ code: String) {
        // QR 코드 검증 로직
        guard code.hasPrefix("BIKE") else {
            alertMessage = "유효하지 않은 QR 코드입니다"
            showAlert = true
            return
        }
        // TODO: 자전거 대여 진행 로직 수행
        
        // 자전거 대여 진행 확인 화면 넘어가기
        router.present(sheet: .confirmRent)
        
    }
    
    private func handleError(_ error: ScanError) {
        alertMessage = "스캔 실패: \(error.localizedDescription)"
        showAlert = true
    }
    
    func dismiss(){
        router.dismissFullScreen()
    }
    
    func dismissAlert(){
        showAlert = false
    }
}
