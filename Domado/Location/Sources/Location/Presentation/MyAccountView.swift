//
//  MuAccountView.swift
//  Location
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

struct MyAccountView: View {
//    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            Color.grayScaleLight.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 네비게이션 타이틀과 X 버튼
                HStack {
                    Spacer()
                        .frame(width: 21)
                    Spacer()
                    
                    Text("내 정보 보기")
                        .customFont(.headline_sm)
                        .foregroundStyle(Color.grayScaleDarker)
                    
                    Spacer()
                    
                    Button {
//                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.interactivePrimary)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 20)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) { // 제일 바깥 -> 스크롤뷰 28
                        VStack(spacing: 0){
                            HStack(spacing: 0){
                                Button {
                                    // 내 쿠폰
                                } label: {
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 159, height: 212) // 나중에 패딩으로 바꿔야할지도..
                                        .foregroundStyle(Color.grayScaleWhite)
                                        .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 0)
                                        .overlay (
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("내 쿠폰")
                                                    .customFont(.batterynumber)
                                                    .foregroundStyle(Color.grayScaleDarker)
                                                    .padding(.bottom, 10)
                                                // 이미지 삽입
                                                ZStack{
                                                    Image("coupon", bundle: .module)
                                                    Image("char1", bundle: .module)
                                                        .offset(x: 20, y: 40)
                                                }
                                            }
                                        )
                                }
                                .padding(.trailing, 16)
                                
                                Button {
                                    // 내 쿠폰
                                } label: {
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 159, height: 212)
                                        .foregroundStyle(Color.grayScaleWhite)
                                        .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 0)
                                        .overlay (
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("결제 관리")
                                                    .customFont(.batterynumber)
                                                    .foregroundStyle(Color.grayScaleDarker)
                                                    .padding(.bottom, 10)
                                                // 이미지 삽입
                                                ZStack{
                                                    Image("cash", bundle: .module)
                                                    Image("char2", bundle: .module)
                                                        .offset(y: 10)
                                                }
                                            }
                                        )
                                }
                            }
                            .padding(.bottom, 20)
                            
                            Button {
                                // 하이바이크 이용방법
                            } label: {
                                RoundedRectangle(cornerRadius: 25)
                                    .overlay(
                                        HStack(spacing: 0){
                                            Text("하이바이크 이용방법")
                                                .customFont(.batterynumber)
                                                .foregroundStyle(Color.grayScaleDarker)
                                            Spacer()
                                        }
                                            .padding(.horizontal, 24)
                                    )
                                    .frame(width: 334, height: 83)
                                    .foregroundStyle(Color.grayScaleWhite)
                                    .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 0)
                                    .padding(.bottom, 20)
                            }
                            
                        }
                        .padding(.horizontal, 12)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color.grayScaleWhite)
                            
                                .frame(width: 366)
                                .frame(maxWidth: .infinity)
                                .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 0)
                                .padding(.horizontal, 12)
                            
                            VStack(alignment:.leading, spacing: 0) {
                                HStack(spacing: 0){
                                    Text("이용기록")
                                        .padding(.top, 24)
                                        .padding(.bottom, 18)
                                    Spacer()
                                }
                                
                                // 이용기록
                                RideHistoryCell()
                                RideHistoryCell()
                                RideHistoryCell()
                                
                                
                            }
                            .padding(.horizontal, 42)
                        }
                        
                    }
                    
                }
            }
        }
    }
    
}

#Preview {
    MyAccountView()
}
