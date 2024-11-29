//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import SwiftUI

// MARK: - Common Components
struct BatteryIndicator: View {
    let level: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pushButtonDark)
                .frame(width: 54, height: 54)
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.stationBatteryGreen)
                    .frame(
                        height: geometry.size.height * CGFloat(level) / 100
                    )
                    .frame(
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
            }
            .clipShape(Circle())
            .frame(width: 54, height: 54)
            
            Text("\(level)")
                .customFont(.batterynumber)
                .foregroundStyle(Color.grayScaleWhite)
        }
    }
}
