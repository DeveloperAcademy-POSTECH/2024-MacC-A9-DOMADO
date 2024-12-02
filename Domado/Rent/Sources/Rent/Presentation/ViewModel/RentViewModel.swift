//
//  Untitled 2.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

import Foundation
import Core
import CodeScanner

@MainActor
public class RentViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var isTorchOn = false
    var alertMessage = ""
    var isProcessingScanning: Bool {
        get {appState.isProcessingScanning}
    }
    
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
            requestBikeRent(result.string)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func requestBikeRent(_ code: String) {
        // QR 코드 검증 로직
        guard !appState.isProcessingScanning else { return }
        appState.startScanning()
        // 6자리 숫자인지 검증
        guard code.count == 6,
              let _ = Int(code) else {
            alertMessage = "유효하지 않은 QR 코드입니다"
            showAlert = true
            return
        }
        // TODO: 자전거 대여 진행 로직 수행
        
        // 자전거 대여 진행 확인 시트 보여주기
        router.present(sheet: .confirmRent)
        resetScanningState()
    }
    
    private func handleError(_ error: ScanError) {
        alertMessage = "스캔 실패: \(error.localizedDescription)"
        showAlert = true
    }
    
    func dismiss(){
        router.dismissFullScreen()
        resetScanningState()
    }
    
    func dismissAlert(){
        showAlert = false
        resetScanningState()
    }
    
    func resetScanningState() {
        // 스캐닝 상태만 리셋
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.appState.doneScanning()
        }
    }
}
