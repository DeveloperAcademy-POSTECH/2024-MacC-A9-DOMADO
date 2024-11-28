//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation
import SwiftUI

public struct UnparkingConfirmView: View {
    
    @StateObject private var vm: UnparkingConfirmViewModel
    
    public init(vm: UnparkingConfirmViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                // Header with close button
                HStack {
                    Text("바이크를 잠금해제할까요?")
                        .customFont(.headline_sm)
                        .padding(.bottom, 4)
                    
                    Spacer()
                    
                    Button(action: {
                        vm.dismissUnparkConfirmView() 
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                }
                
                // Description section
                VStack(alignment: .leading, spacing: 12) {
                    Text("잠금해제하면 다시 바이크를 탈 수 있어요.")
                        .customFont(.body_sm_regular)
                        .lineSpacing(4)
                    
                    Text("반납 안내")
                        .customFont(.headline_md)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundStyle(Color.interactivePrimary)
                            .frame(width: 26, height: 22)
                        Text("무은재 기념관")
                            .customFont(.headline_md)
                    }
                    
                    Text("바이크를 반납하려면 스테이션에 다시 꽂아 주세요.\n스테이션 외에 주차 시 반납이 인정되지 않습니다.")
                        .customFont(.body_md_regular)
                        .lineSpacing(4)
                }
            }
            
            // Bottom slide button
            SlideButton(
                title: "바이크 잠금해제 →",
                slideIcon: "bicycle",
                lockIcon: "lock.open"
            ) {
                vm.unparkBike()  // Added method call
            }
        }
        .padding(.horizontal, 24)
    }
    
}
