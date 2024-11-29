//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import SwiftUI

struct DockView: View {
    let number: Int
    let batteryLevel: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(number)")
                .customFont(.caption_md_semibold)
                .foregroundStyle(Color.grayScaleLightActive)
                .padding(.bottom, 4)
            
            if let batteryLevel = batteryLevel {
                BatteryIndicator(level: batteryLevel)
            } else {
                EmptyDockIndicator()
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 6)
    }
}
