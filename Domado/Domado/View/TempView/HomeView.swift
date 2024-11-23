//
//  HomeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            // WebSocket 연결 상태 표시
            HStack {
                Circle()
                    .fill(vm.isWebSocketConnected ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
                
                Text(vm.isWebSocketConnected ? "연결됨" : "연결 안됨")
                    .font(.caption)
            }
            .padding()
            
            // 마지막 수신 메시지 표시 (있는 경우)
            if let lastMessage = vm.lastMessage {
                Text(lastMessage)
                    .font(.subheadline)
                    .padding()
            }
            
            Spacer()
            
            HStack {
                Button {
                    // 내정보 처리
                } label: {
                    Text("내정보")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button {
                    vm.rentBikeWithQR()
                } label: {
                    Text("QR 찍고 자전거 대여하기")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .alert("알림", isPresented: $vm.showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(vm.alertMessage)
        }
    }
}
