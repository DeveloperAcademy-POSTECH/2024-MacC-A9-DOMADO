//
//  Dock.swift
//  Location
//
//  Created by yoomin on 11/24/24.
//

import SwiftUI

struct Dock: View, Identifiable {
    let id = UUID()
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
    Dock(number: 4, batteryLevel: 50)
}
