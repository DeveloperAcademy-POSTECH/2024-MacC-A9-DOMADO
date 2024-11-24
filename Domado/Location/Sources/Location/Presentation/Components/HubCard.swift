//
//  HubCard.swift
//  Location
//
//  Created by yoomin on 11/22/24.
//

import SwiftUI
import Core

struct HubCard: View {
    var width: CGFloat = 356
    var height: CGFloat = 288
    var hubName: String = "박태준 학술 정보관"
    
    var body: some View {
        Rectangle()
            .fill(Color.grayScaleWhite)
            .overlay(
                VStack(spacing: 0) {
                    HStack(spacing: 8){
                        Image(systemName: "mappin.circle.fill") // 이미지 변경
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(Color.stationDefault)
                        Text(hubName)
                            .customFont(.station_lg_bold)
                            .foregroundStyle(Color.grayScaleDarker)
                    }
                    .padding(.bottom, 14)
                    
                    Text("대여가능한 바이크 수")
                        .customFont(.caption_md_semibold)
                        .foregroundStyle(Color.grayScaleLightActive)
                        .padding(.bottom, 5)
                    
                    HStack(spacing: 6){
                        Image(systemName: "bicycle") // 이미지 변경
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(Color.grayScaleLightActive)
                        Text("5대")
                            .customFont(.station_lg_bold)
                            .foregroundStyle(Color.grayScaleDarker)
                    }
                    .padding(.bottom, 14)
                    
                    Spacer()
                    
                    StationView()
                }
                    .padding(18)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
        
    }
}

#Preview {
    HubCard()
}
