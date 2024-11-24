//
//  RentProgressView.swift
//  Rent
//
//  Created by 고재보 on 11/23/24.
//


import SwiftUI
import Core

public struct RentProgressView: View {
    @StateObject private var viewModel: RentProgressViewModel
    
    public init(viewModel: RentProgressViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            // 상단
            HStack {
                Text("바이크를 대여할까요?")
                    .customFont(.headline_sm)
                
                Spacer()
                
                Button(action: { viewModel.dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.interactivePrimary)
                        .fontWeight(.bold)
                }
            }
            .padding()
            
            VStack(alignment: .center, spacing: 25) {
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundStyle(Color.interactivePrimary)
                    Text(viewModel.stationName)
                        .customFont(.station_lg_bold)
                }
                
                // 맵 뷰
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 276, height: 186)
                    .foregroundStyle(Color.gray.opacity(0.2))
                
                // 정보 섹션
                VStack {
                    Text("바이크 \(viewModel.bikeId)은")
                        .customFont(.body_md_regular)
                        .opacity(0.5)
                    
                    Text("스테이션으로 돌아가야 반납이 가능해요")
                        .customFont(.body_md_bold)
                }
                
                // 쿠폰 토글
                HStack(alignment: .center, spacing: 15) {
                    Text("쿠폰")
                        .customFont(.body_md_regular)
                    
                    Text("30분 무료 이용권")
                        .customFont(.body_sm_regular)
                        .foregroundColor(.gray)
                    
                    Toggle("", isOn: $viewModel.isRental)
                        .tint(.interactivePrimary)
                }
                .padding()
                
                // 하단 버튼
                HStack(spacing: 0) {
                    SlideButton(
                        title: "바이크 대여하기 →",
                        slideIcon: "bicycle",
                        lockIcon: "lock.open"
                    ) {
                        viewModel.startRental()
                    }
                }
            }
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    RentProgressView(viewModel: RentProgressViewModel(
        bikeId: "73RY-SI33P1",
        stationName: "무은재 기념관 스테이션",
        onComplete: {},
        onDismiss: {}
    ))
}
