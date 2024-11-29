//
//  HubCard.swift
//  Location
//
//  Created by yoomin on 11/22/24.
//

import SwiftUI
import Core

struct HubCard: View {
    let hub: Hub
    var width: CGFloat = 356
    var height: CGFloat = 288
    
    var body: some View {
        Rectangle()
            .fill(Color.grayScaleWhite)
            .overlay(
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image("mappin", bundle: .module)
                        Text(hub.hubName)
                            .customFont(.station_lg_bold)
                            .foregroundStyle(Color.grayScaleDarker)
                    }
                    .padding(.bottom, 14)
                    
                    Text("대여가능한 바이크 수")
                        .customFont(.caption_md_semibold)
                        .foregroundStyle(Color.grayScaleLightActive)
                        .padding(.bottom, 5)
                    
                    HStack(spacing: 6) {
                        Image("bike", bundle: .module)
                        Text("\(hub.totalAvailableBikes)대")
                            .customFont(.station_lg_bold)
                            .foregroundStyle(Color.grayScaleDarker)
                    }
                    .padding(.bottom, 14)
                    
                    Spacer()
                    
                    StationView(stations: hub.stations)
                }
                .padding(18)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
    }
}
