//
//  HiBikeCard.swift
//  Location
//
//  Created by yoomin on 11/24/24.
//

import SwiftUI
import Core

struct HiBikeCard: View {
    var width: CGFloat = 338
    var height: CGFloat = 266
    var bikeName: String = "73RY-SI33P1"
    var homeHubName: String = "무은재 기념관"
    
    let batteryLevel: Int = 78
    
    var body: some View {
        Rectangle()
            .fill(Color.grayScaleWhite)
            .overlay(
                VStack(spacing: 0) {
                    HStack(spacing: 8){
                        Text("하이바이크 \(bikeName)")
                            .customFont(.body_md_bold)
                            .foregroundStyle(Color.grayScaleDarkHover)
                        
                        Text("은")
                            .customFont(.body_md_regular)
                            .foregroundStyle(Color.grayScaleNormal)
                    }
                    .padding(.bottom, 9)
                    
                    HStack(spacing: 8){
                        Image(systemName: "house.fill") // 이미지 변경
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(Color.stationDefault)
                        Text(homeHubName)
                            .customFont(.station_lg_bold)
                            .foregroundStyle(Color.grayScaleDarker)
                    }
                    .padding(.bottom, 10)
                    
                    Text("으로 돌아가야해요.")
                        .customFont(.body_md_regular)
                        .foregroundStyle(Color.grayScaleNormal)
                        .padding(.bottom, 34)
                    
                    HStack(spacing: 13){
                        ZStack{
                            Rectangle()
                                .fill(Color.hibikeYellowLight)
                                .frame(width: 210, height: 112)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    VStack(alignment: .listRowSeparatorLeading, spacing: 0) {
                                        Text("하이바이크의 혜택")
                                            .customFont(.headline_xsm)
                                            .foregroundStyle(Color.brownNormal)
                                            .padding(9)
                                        Text("이 자전거 타면 하이를 GET!\n모으는 재미, 놓치지 마세요!")
                                            .customFont(.body_sm_regular)
                                            .foregroundStyle(Color.brownLightActive)
                                        
                                    }
                                )
                            
                            // 하이바이크 스티커를 붙이기..
                            Rectangle()
                                .frame(width:42, height:42)
                                .offset(x: -50, y: -50)
                        }
                        
                        VStack(spacing: 0){
                            Text("배터리 상태")
                                .customFont(.caption_md_semibold)
                                .foregroundStyle(Color.grayScaleLightActive)
                                .padding(.bottom, 11)
                            
                            ZStack {
                                Circle()
                                    .fill(Color.pushButtonDark)
                                    .frame(width: 54, height: 54)
                                
                                GeometryReader { geometry in
                                    Rectangle()
                                        .fill(Color.stationBatteryGreen)
                                        .frame(
                                            height: geometry.size.height * CGFloat(batteryLevel) / 100
                                        )
                                        .frame(
                                            maxHeight: .infinity,
                                            alignment: .bottom
                                        )
                                }
                                .clipShape(Circle())
                                .frame(width: 54, height: 54)
                                
                                Text("\(batteryLevel)")
                                    .customFont(.batterynumber)
                                    .foregroundStyle(Color.grayScaleWhite)
                            }
           
                        }
                        
                    }
                    
                }
                    .padding(8)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
        
    }
}

#Preview {
    HiBikeCard()
}
