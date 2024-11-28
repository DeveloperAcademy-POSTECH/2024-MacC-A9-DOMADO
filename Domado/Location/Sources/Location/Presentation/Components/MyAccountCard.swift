//
//  Untitled.swift
//  Location
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

struct MyAccountCard: View {
    var width: CGFloat = 358
    var height: CGFloat = 330
    var userName: String = "김경림"
    var userId: String = "thou8and"
    
    @State private var showMyAccountView = false  // 상태 변수 추가
    
    
    var body: some View {
        Rectangle()
            .fill(Color.grayScaleWhite)
            .overlay(
                VStack(spacing:0){
                    HStack {
                        VStack(spacing:0){
                            Text("\(userName)님")
                                .customFont(.station_lg_bold)
                                .foregroundStyle(Color.grayScaleDarker)
                                .padding(.bottom, 3)
                            Text(userId)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                        }
                        Spacer()
                        Button(action: {
                            showMyAccountView = true
                        }, label: {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.grayScaleLightHover)
                                .overlay(
                                    HStack(spacing: 8){
                                        Image("myAccount", bundle: .module)
                                        Text("내 정보 보기")
                                            .customFont(.caption_md_semibold)
                                            .foregroundColor(Color.grayScaleDarkHover)
                                    }
                                )
                                .frame(width: 125, height: 41)
                            
                        })
                    }
                    .padding(.bottom, 16)
                    CouponBook()
                }
                
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
            .fullScreenCover(isPresented: $showMyAccountView) {
                            MyAccountView()  // MyAccountView 모달로 표시
                        }
        
    }
}

#Preview {
    MyAccountCard()
}
