//
//  HomeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI
import Core
import MapKit

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    
    var body: some View {
        ZStack{
            Map(position: $vm.position) {
                UserAnnotation()
            }
            .mapStyle(.standard)
            .edgesIgnoringSafeArea(.all)
            
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
                
                HomeInfoCard {
                    print("내정보 쿠폰카드 보여주기")
                } rentAction: {
                    vm.rentBikeWithQR()
                }
                
                
            }
        }
        .alert("알림", isPresented: $vm.showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(vm.alertMessage)
        }
    }
}
