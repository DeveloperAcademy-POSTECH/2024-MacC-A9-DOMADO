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
    
    private func requestBikeRent(_ qrContent: String) {
        guard !appState.isProcessingScanning else { return }
        appState.startScanning()
        
        do {
            guard let jsonData = qrContent.data(using: .utf8) else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "QR 코드 데이터 변환 실패"])
            }
            
            let bikeData = try JSONDecoder().decode(BikeQRData.self, from: jsonData)
            
            guard bikeData.bikeCode.hasPrefix("BIKE") else {
                alertMessage = "유효하지 않은 자전거 코드입니다"
                showAlert = true
                return
            }
            
            // 파싱된 데이터를 AppState에 저장
            appState.setCurrentScanningBike(bikeData)
            
            // 자전거 대여 진행 확인 시트 보여주기
            router.present(sheet: .confirmRent)
            resetScanningState()
            
        } catch {
            alertMessage = "잘못된 QR 코드 형식입니다: \(error.localizedDescription)"
            showAlert = true
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.appState.doneScanning()
        }
    }
}
