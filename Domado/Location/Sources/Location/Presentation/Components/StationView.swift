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
    
    // 샘플 스테이션
    struct Station: Identifiable {
        let id = UUID()
        let docks: [Dock]
    }
    
    // 샘플 데이터
    let stations = [
        Station(docks: [
            Dock(number: 1, batteryLevel: nil),
            Dock(number: 2, batteryLevel: 56),
            Dock(number: 3, batteryLevel: nil),
            Dock(number: 4, batteryLevel: 78)
        ]),
        Station(docks: [
            Dock(number: 1, batteryLevel: 90),
            Dock(number: 2, batteryLevel: nil),
            Dock(number: 3, batteryLevel: 45),
            Dock(number: 4, batteryLevel: 23)
        ]),
        Station(docks: [
            Dock(number: 1, batteryLevel: 67),
            Dock(number: 2, batteryLevel: 88),
            Dock(number: 3, batteryLevel: nil),
            Dock(number: 4, batteryLevel: nil)
        ])
    ]

    
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
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    
                    ForEach(stations) { station in  // stations 배열을 순회
                        Rectangle()
                            .fill(Color.stationBatteryBack)
                            .overlay(
                                HStack {
                                    ForEach(station.docks) { dock in
                                        Dock(number: dock.number, batteryLevel: dock.batteryLevel)
                                    }
                                }
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: width, height: height)
                    }
                    .containerRelativeFrame(.horizontal, alignment: .center)
                    
                }
                .scrollTargetLayout() // 스크롤 뷰의 각 아이템을 스냅 대상으로 만듭니다
            }
            .scrollTargetBehavior(.viewAligned) // 스크롤이 멈추면 가장 가까운 아이템에 자동으로 정렬됩니다
            .scrollIndicators(.hidden)

        }
    }
}

#Preview {
    StationView()
}
