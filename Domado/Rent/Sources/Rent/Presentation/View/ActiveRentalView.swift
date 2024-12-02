//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import SwiftUI
import Core
import MapKit

public struct ActiveRentalView: View {
    
    @StateObject private var vm: ActiveRentViewModel
    
    public init(vm: ActiveRentViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ZStack{
            Map(position: $vm.position) {
                UserAnnotation()
            }
            .mapStyle(.standard)
            // MARK: 추후 삭제
            .overlay(alignment: .topLeading){
                Button {
                    vm.showPaymentGuide()
                } label: {
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .opacity(0)
                }
            }
            .overlay(alignment: .bottom) {
                BikeInfoCard(remainingTime: vm.elapsedTime, batteryLevel: vm.batteryLevel, isParked: vm.isParked) {
                    // 자전거 주차하기
                    vm.parkBike()
                }
                .padding()
            }
            
            if vm.isPaymentProcessing {
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
                        Text("요금 정산중입니다...")
                            .customFont(.headline_md)
                            .foregroundColor(.white)
                        
                        Text("바이크 요금은 스테이션에 주차가\n확인된 순간까지만 계산되요")
                            .customFont(.body_sm_regular)
                            .foregroundColor(.white)
                    }

                }
                .padding(.bottom, 150)
            }
        }
    }
}
