//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/28/24.
//

import Core
import SwiftUI

public struct ReturnBikeView: View {
    
    @StateObject private var vm: ReturnBikeViewModel
    
    public init(vm: ReturnBikeViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                // Header with close button
                HStack {
                    Text("바이크 반납하기")
                        .customFont(.headline_sm)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 8)
                
                // Description section
                VStack(alignment: .leading, spacing: 8) {
                    Text("바이크가 스테이션에 안전하게 꽂힌 걸 확인했어요\n덕분에 바이크가 잘 돌아왔어요! ")
                        .customFont(.body_sm_regular)
                        .lineSpacing(4)
                        .padding(.bottom)
                }
                    
            }
            
            // Bottom slide button
            SlideButton(
                title: "요금 결제하기 →",
                slideIcon: "creditcard",
                lockIcon: "faxmachine"
            ) {
                print("결제가 완료되었습니다!")
            }
        }
        .padding(.horizontal, 24)
    }
}
