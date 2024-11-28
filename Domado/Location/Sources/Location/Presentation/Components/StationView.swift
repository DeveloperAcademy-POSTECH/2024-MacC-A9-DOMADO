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
    //    var stationName: String = "A 스테이션"
    
    
    // 현재 보여지는 스테이션의 인덱스를 추적하기 위한 상태 변수
    @State private var currentIndex: Int = 0
    // ScrollViewReader를 저장하기 위한 상태 변수
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    
    // 샘플 스테이션 모델
    struct Station: Identifiable {
        let id = UUID()
        let stationName: String
        let docks: [Dock]
    }
    
    // 샘플 데이터
    let stations = [
        Station(
            stationName: "A 스테이션",
            docks: [
                Dock(number: 1, batteryLevel: nil),
                Dock(number: 2, batteryLevel: 56),
                Dock(number: 3, batteryLevel: nil),
                Dock(number: 4, batteryLevel: 78)
            ]),
        Station(
            stationName: "B 스테이션",
            docks: [
                Dock(number: 1, batteryLevel: 90),
                Dock(number: 2, batteryLevel: nil),
                Dock(number: 3, batteryLevel: 45),
                Dock(number: 4, batteryLevel: 23)
            ]),
        Station(
            stationName: "C 스테이션",
            docks: [
                Dock(number: 1, batteryLevel: 67),
                Dock(number: 2, batteryLevel: 88),
                Dock(number: 3, batteryLevel: nil),
                Dock(number: 4, batteryLevel: nil)
            ])
    ]
    
    // 현재 선택된 스테이션의 이름을 반환하는 계산 프로퍼티
    var currentStationName: String {
        stations[currentIndex].stationName
    }
    
    // 스테이션 이동 가능 여부를 확인하는 계산 프로퍼티
    var goPrevious: Bool {
        return currentIndex > 0
    }
    var goNext: Bool {
        return currentIndex < stations.count - 1
    }
    
    // 지정된 인덱스로 스크롤하는 함수
    func scrollToIndex(_ index: Int, anchor: UnitPoint = .center) {
        withAnimation {
            // ScrollViewProxy를 사용하여 해당 인덱스의 스테이션으로 스크롤
            scrollProxy?.scrollTo(stations[index].id, anchor: anchor)
            currentIndex = index
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0){
            Text("바이크 배터리 상태")
                .customFont(.caption_md_semibold)
                .foregroundStyle(Color.grayScaleLightActive)
                .padding(5)
            
            HStack(spacing: 0){
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
            
            // ScrollViewReader를 사용하여 프로그래매틱 스크롤 구현
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(Array(stations.enumerated()), id: \.element.id) { index, station in
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
                                .id(station.id) // 각 스테이션에 고유 ID 부여
                            //                                .onAppear {
                            //                                    // 현재 인덱스의 스테이션이 나타날 때 ScrollViewProxy 저장
                            //                                    if index == currentIndex {
                            //                                        scrollProxy = proxy
                            //                                    }
                            //                                }
                        }
                        .containerRelativeFrame(.horizontal, alignment: .center)
                        
                    }
                    .scrollTargetLayout() // 스크롤 뷰의 각 아이템을 스냅 대상으로 지정
                }
                .scrollTargetBehavior(.viewAligned) // 스크롤 시 자동으로 가장 가까운 아이템에 정렬되도록 설정
                .scrollIndicators(.hidden)
                // currentIndex가 변경될 때마다 해당 인덱스로 스크롤
                //                .onChange(of: currentIndex) { oldValue, newValue in
                //                    scrollToIndex(newValue)
                //                }
                .scrollPosition(id: .init(get: {
                    stations[currentIndex].id
                }, set: { newPosition in
                    // 스크롤 위치가 변경되면 해당하는 인덱스를 찾아 currentIndex 업데이트
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

#Preview {
    StationView()
}
