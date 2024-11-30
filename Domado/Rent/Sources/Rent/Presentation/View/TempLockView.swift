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
                Image("pause")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 95, height: 75)
                    .foregroundColor(.white)
                
                VStack(spacing: 4) {
                    Text(vm.isHiBike ? "새로운 바이크 주인을 찾고 있어요..": (vm.isPassed ? "바이크가 새로운 주인을 찾았어요" :"바이크가 안전하게 잠겨있어요"))
                        .customFont(.headline_md)
                        .foregroundColor(.white)
                    
                    Text(vm.isHiBike ? "보통 새로운 주인은 30분 이내로 나타나요": "")
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
                            remainingTime: "30:21",
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
        // MARK: 추후 삭제
        .overlay(alignment: .topLeading){
            Button {
                vm.showCompleteHiBike()
            } label: {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .opacity(0)
            }
        }
    }
}
