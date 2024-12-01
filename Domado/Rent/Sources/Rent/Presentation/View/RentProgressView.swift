//
//  RentProgressView.swift
//  Rent
//
//  Created by 고재보 on 11/23/24.
//


import SwiftUI
import Core
import MapKit

public struct RentProgressView: View {
    @StateObject private var viewModel: RentProgressViewModel
    
    public init(viewModel: RentProgressViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // 상단
            HStack {
                Text("바이크를 대여할까요?")
                    .customFont(.headline_sm)
                
                Spacer()
                
                Button(action: { viewModel.dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.interactivePrimary)
                        
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 8)
            
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundStyle(Color.interactivePrimary)
                    Text(viewModel.stationName)
                        .customFont(.station_lg_bold)
                }
                .padding(.top)
                
                // 돌아갈 스테이션 표시
                Map(position: $viewModel.cameraPosition) {
                    Marker(viewModel.stationName, coordinate: viewModel.coordinate)
                        .tint(Color.MylocationMarker)
                }
                .frame(width: 280,height: 186)
                .cornerRadius(20)
                .foregroundStyle(Color.gray.opacity(0.2))
                .padding(.horizontal)
                
                // 정보 섹션
                VStack(spacing: 8) {
                    Text("바이크 \(viewModel.bikeId)은")
                        .customFont(.body_md_regular)
                        .opacity(0.5)
                    
                    Text("반납 구역으로 돌아가야 반납이 가능해요")
                        .customFont(.body_md_bold)
                }
                
                VStack{
                    // 쿠폰 토글
                    HStack(alignment: .center, spacing: 15) {
                        Text("쿠폰")
                            .customFont(.body_md_regular)
                        
                        Text("30분 무료 이용권")
                            .customFont(.body_sm_regular)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.isApplyCoupon)
                            .tint(.interactivePrimary)
                    }
                    .padding()
            
                    
                    // 하단 버튼
                    SlideButton(
                        title: "바이크 대여하기 →",
                        slideIcon: "bicycle",
                        lockIcon: "lock.open"
                    ) {
                        viewModel.startRental()
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 20)
            }
        }
        .onDisappear{
            viewModel.resetScanningState()
        }
    }
}
