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
        VStack(alignment: .leading, spacing: 24) {
            // Header with close button
            HStack {
                Text("바이크를 주차할까요?")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    vm.cancelParking()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
            }
            
            // Description text
            VStack(alignment: .leading, spacing: 16) {
                Text("자전거를 주차하시면 잠금장치가 걸려 안전하게\n보관됩니다. 하지만 주차 상태에서도 요금이 계속\n부과됩니다.")
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
                
                Text("안전 주차 안내")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("장애인 주차 구역 및 점자블록은 주차하지 말아 주세요.\n이 구역에 주차 시, 자전거가 견인될 수 있습니다.")
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            
            
            // Bottom button
            SlideButton {
                vm.parkBike()
            }

        }
        .padding(24)
    }
    
}
