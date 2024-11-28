//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import SwiftUI

public struct ParkingConfirmView: View {
   
    @StateObject private var vm:ParkingConfirmViewModel
    
    public init(vm: ParkingConfirmViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                // Header with close button
                HStack {
                    Text("바이크를 주차할까요?")
                        .customFont(.headline_sm)
                    
                    Spacer()
                    
                    Button(action: {
                        vm.cancelParking()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                }
                .padding(.bottom, 8)
                
                // Description section
                VStack(alignment: .leading, spacing: 8) {
                    Text("자전거를 주차하시면 잠금장치가 걸려 안전하게\n보관됩니다. 하지만 주차 상태에서도 요금이 계속\n부과됩니다.")
                        .customFont(.body_sm_regular)
                        .lineSpacing(4)
                        .padding(.bottom)
                    
                    Text("안전 주차 안내")
                        .customFont(.headline_md)
                        .fontWeight(.bold)
                    
                    Text("장애인 주차 구역 및 점자블록은 주차하지 말아 주세요.\n이 구역에 주차 시, 자전거가 견인될 수 있습니다.")
                        .customFont(.body_md_regular)
                        .lineSpacing(4)
                }
            }
            
            // Bottom slide button
            SlideButton(
                title: "바이크 주차하기 →",
                slideIcon: "bicycle",
                lockIcon: "lock.fill"
            ) {
                vm.parkBike()
            }
        }
        .padding(.horizontal, 24)
    }
    
}
