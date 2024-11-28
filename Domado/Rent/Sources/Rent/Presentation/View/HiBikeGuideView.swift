//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/28/24.
//

import SwiftUI

public struct HiBikeGuideView: View {
    
    @StateObject private var vm: HiBikeGuideViewModel
    
    public init(vm: HiBikeGuideViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                // Header with close button
                HStack {
                    Text("하이바이크 전환하기")
                        .customFont(.headline_lg)
                        .padding(.bottom, 4)
                    
                    Spacer()
                    
                    Button(action: {
                        vm.dismissGuide()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                }
                
                // Description section
                VStack(alignment: .leading, spacing: 12) {
                    Text("하이바이크 기능으로 바이크를 넘기면 반납 의무가 \n다음 이용자에게 넘어가서 반납할 필요가 없어져요.")
                        .customFont(.body_md_regular)
                        .lineSpacing(4)
                    
                    Text("요금 안내")
                        .customFont(.headline_md)
                        .padding(.top)
                    
                    Text("하이바이크는 주차 상태로 유지되지만, \n다음 이용자가 나타날때까지 요금이 계속 부과돼요.")
                        .customFont(.body_md_regular)
                    
                    Text("잠금 해제시")
                        .customFont(.headline_md)
                        .padding(.top)
                    
                    Text("전환하기 기능은 언제든지 켜고 끌 수 있으며,\n바이크를 다시 잠금 해제하면 하이바이크 전환하기\n기능이 자동으로 종료돼요.")
                        .customFont(.body_md_regular)
                        .lineSpacing(4)
                }
            }
            
        }
        .padding(.horizontal, 24)
    }
}

