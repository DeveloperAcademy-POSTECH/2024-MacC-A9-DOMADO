//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import SwiftUI
import MapKit

public struct TempLockView: View {
    
    @StateObject private var vm: TempLockViewModel
    
    public init(vm: TempLockViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ZStack {
            // 배경 지도
            Map(position: $vm.position) {
                UserAnnotation()
            }
            .mapStyle(.standard)
            
            Color.gray.opacity(0.5).ignoresSafeArea()
            
            // 중앙 상태 표시
            VStack(spacing: 16) {
                // 장갑 아이콘과 메시지
                Image(systemName: "hand.raised.fill") // 실제 장갑 아이콘으로 교체 필요
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                
                VStack(spacing: 4) { // 텍스트 사이 간격을 4로 줄임
                    Text(vm.isHiBike ? "새로운 바이크 주인을 찾고 있어요..": "바이크가 안전하게 잠겨있어요")
                        .customFont(.headline_md)
                        .foregroundColor(.white)
                    
                    Text(vm.isHiBike ? "보통 새로운 주인은 30이내로 나타나요": "")
                        .customFont(.body_sm_regular)
                        .foregroundColor(.white)
                }

            }
            .padding(.bottom, 150)
            
            // 하단 카드 영역
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    // 하이바이크 전환 토글
                    HibikeToggle(isOn: $vm.isHiBike) {
                        // 하이바이크 전환 요청
                    } helpAction: {
                        vm.showHikeBikeGuide()
                    }
                    
                    // 이용 정보 카드
                    VStack(spacing: 20) {
                        BikeInfoCard(
                            remainingTime: "52:21",
                            batteryLevel: "21km",
                            isParked: true
                        ) {
                            vm.showUnparkConfirmView()
                        }
                        .frame(height: 180)
                    }
                    .padding()
                }
            }
        }
    }
}
