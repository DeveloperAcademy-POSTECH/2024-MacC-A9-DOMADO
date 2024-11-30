//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/30/24.
//

import Core
import SwiftUI

public struct HiBikeCompleteView: View {
    
    public init(){
        
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                // Header with close button
                HStack {
                    Text("바이크 넘겨주기")
                        .customFont(.headline_sm)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 8)
                
                // Description section
                VStack(alignment: .leading, spacing: 8) {
                    Text("다음 사용자가 바이크를 가져갔어요.\n이제부터 정산을 시작할게요.")
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

#Preview {
    HiBikeCompleteView()
}
