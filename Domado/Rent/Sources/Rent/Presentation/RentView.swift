//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

import SwiftUI
import CodeScanner

public struct RentView: View {
    @StateObject private var viewModel: RentViewModel
    
    public init(viewModel: RentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            CodeScannerView(
                codeTypes: [.qr],
                simulatedData: "BIKE-123", // 테스트용
                completion: viewModel.handleScan
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.green, lineWidth: 2)
                    .frame(width: 250, height: 250)
            )
            
            VStack {
                // 닫기 버튼
                HStack {
                    Spacer()
                    Button {
                        viewModel.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding()
                }
                
                Spacer()
                
                // 안내 메시지
                Text("자전거 QR 코드를 스캔해주세요")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert("스캔 결과", isPresented: $viewModel.showAlert) {
            Button("확인") { viewModel.dismissAlert() }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}
