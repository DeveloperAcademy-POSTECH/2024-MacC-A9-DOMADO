//
//  StationView.swift
//  Location
//
//  Created by yoomin on 11/22/24.
//

import SwiftUI
import Core

struct StationView: View {
    let stations: [Station]
    var width: CGFloat = 326
    var height: CGFloat = 86
    
    @State private var currentIndex: Int = 0
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    var currentStationName: String {
        stations[currentIndex].stationName
    }
    
    var goPrevious: Bool {
        return currentIndex > 0
    }
    
    var goNext: Bool {
        return currentIndex < stations.count - 1
    }
    
    func scrollToIndex(_ index: Int, anchor: UnitPoint = .center) {
        withAnimation {
            scrollProxy?.scrollTo(stations[index].id, anchor: anchor)
            currentIndex = index
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("바이크 배터리 상태")
                .customFont(.caption_md_semibold)
                .foregroundStyle(Color.grayScaleLightActive)
                .padding(5)
            
            HStack(spacing: 0) {
                Button {
                    if goPrevious {
                        scrollToIndex(currentIndex - 1)
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .bold()
                        .foregroundColor(goPrevious ? Color.interactivePrimary : Color.grayScaleLightHover)
                }
                
                Text(currentStationName)
                    .customFont(.button_md_semibold)
                    .foregroundStyle(Color.grayScaleNormal)
                    .padding(.horizontal, 73)
                
                Button {
                    if goNext {
                        scrollToIndex(currentIndex + 1)
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .bold()
                        .foregroundColor(goNext ? Color.interactivePrimary : Color.grayScaleLightHover)
                }
            }
            .padding(.bottom, 11)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(stations) { station in
                            Rectangle()
                                .fill(Color.stationBatteryBack)
                                .overlay(
                                    HStack {
                                        ForEach(0..<station.capacity, id: \.self) { dockIndex in
                                            if let bike = station.availableBikes.first(where: { $0.currentDockId == dockIndex + 1 }) {
                                                DockView(number: dockIndex + 1, batteryLevel: bike.batteryLevel)
                                            } else {
                                                DockView(number: dockIndex + 1, batteryLevel: nil)
                                            }
                                        }
                                    }
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: width, height: height)
                                .id(station.id)
                        }
                        .containerRelativeFrame(.horizontal, alignment: .center)
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .scrollPosition(id: .init(get: {
                    stations[currentIndex].id
                }, set: { newPosition in
                    if let newPosition = newPosition,
                       let index = stations.firstIndex(where: { $0.id == newPosition }) {
                        currentIndex = index
                    }
                }))
                .onAppear {
                    scrollProxy = proxy
                }
            }
        }
    }
}
