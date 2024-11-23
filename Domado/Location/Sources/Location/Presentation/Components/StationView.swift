//
//  StationView.swift
//  Location
//
//  Created by yoomin on 11/22/24.
//

import SwiftUI
import Core

struct StationView: View {
    var width: CGFloat = 326
    var height: CGFloat = 86
    var stationName: String = "A 스테이션"
    
    var goPrevious: Bool = true
    var goNext: Bool = true
    
    var body: some View {
        VStack(spacing: 0){
            Text("바이크 배터리 상태")
                .customFont(.caption_md_semibold)
                .foregroundStyle(Color.grayScaleLightActive)
                .padding(5)
            
            HStack(spacing: 0){
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .bold()
                        .foregroundColor(goPrevious ? Color.interactivePrimary : Color.grayScaleLightHover)
                }
                
                Text(stationName)
                    .customFont(.button_md_semibold)
                    .foregroundStyle(Color.grayScaleNormal)
                    .padding(.horizontal, 73)
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.right")
                        .bold()
                        .foregroundColor(goNext ? Color.interactivePrimary : Color.grayScaleLightHover)
                }
                
            }
            .padding(.bottom, 11)
            
            Rectangle()
                .fill(Color.stationBatteryBack)
                .overlay(
                    HStack {
                        //ForEach
                        Dock(number: 1, batteryLevel: nil)
                        Dock(number: 2, batteryLevel: 56)
                        Dock(number: 3, batteryLevel: nil)
                        Dock(number: 4, batteryLevel: 78)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: width, height: height)
            
        }
    }
}
struct Dock: View {
    let number: Int
    let batteryLevel: Int?
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(number)")
                .customFont(.caption_md_semibold)
                .foregroundStyle(Color.pushButtonDark)
            
            if let batteryLevel = batteryLevel {
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
            } else {
                Circle()
                    .fill(Color.pushButtonLight)
                    .frame(width: 54, height: 54)
                    .overlay(
                        Text("대여중")
                            .customFont(.body_sm_regular)
                            .foregroundStyle(Color.pushButtonDark)
                    )
            }
        }
    }
}

#Preview {
    StationView()
}
