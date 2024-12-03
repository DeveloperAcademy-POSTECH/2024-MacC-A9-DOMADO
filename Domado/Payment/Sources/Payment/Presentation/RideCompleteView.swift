//
//  RideCompleteView.swift
//  Payment
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

public struct RideCompleteView: View {
    @StateObject private var vm: RideCompleteViewModel 
    
    public init(vm: RideCompleteViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ZStack{
            Color.grayScaleWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    Spacer()
                        .frame(width: 21)
                    Spacer()
                    
                    Text("바이크 반납 완료")
                        .customFont(.headline_sm)
                        .foregroundStyle(Color.grayScaleDarker)
                    
                    Spacer()
                    
                    Button {
                        
                        vm.goHomeView()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.interactivePrimary)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 23)
                .padding(.top, 12)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("결제 완료")
                        .customFont(.headline_sm)
                        .foregroundStyle(Color.grayScaleDarkHover)
                        .padding(.bottom, 7)
                    Text("\(vm.fareAmount)원")
                        .customFont(.amount_lg_bold)
                        .foregroundStyle(Color.grayScaleDarker)
                        .padding(.bottom, 29)
                    
                    VStack(alignment: .leading, spacing: 15){
                        
                        HStack(spacing: 10) {
                            Text("반납 지역")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(vm.homeHubName)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("이용 시간")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(vm.rideTime)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("쿠폰 내역")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(vm.appliedCoupon)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("결제 수단")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(vm.paymentMethod)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("금액")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text("\(vm.fareAmount)원")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                    }
                    .padding(.bottom, 28)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.grayScaleWhite)
                        .frame(height: 91)
                        .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 0)
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 0){
                                    Text("이용 시간")
                                        .customFont(.body_sm_regular)
                                        .foregroundStyle(Color.grayScaleLightActive)
                                        .padding(.bottom, 2)
                                    HStack(spacing: 0){
                                        Image("time", bundle: .module)
                                            .padding(.trailing, 7)
                                        
                                        Text(vm.rideDuration)
                                            .customFont(.station_lg_bold)
                                            .foregroundStyle(Color.grayScaleDarker)
                                    }
                                }
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 0){
                                    Text("주행 거리")
                                        .customFont(.body_sm_regular)
                                        .foregroundStyle(Color.grayScaleLightActive)
                                        .padding(.bottom, 2)
                                    HStack(spacing: 0){
                                        Image(systemName: "location.circle.fill")
                                            .foregroundStyle(Color.grayScaleLightActive)
                                            .font(.system(size: 16))
                                            .padding(.trailing, 4)
                                        
                                        Text("\(vm.rideDistance)km")
                                            .customFont(.station_lg_bold)
                                            .foregroundStyle(Color.grayScaleDarker)
                                    }
                                }
                            }
                                .padding(.horizontal, 32)
                        )
                        .padding(.bottom, 25)
                    
                    CouponBook(title: "다음엔 하이바이크를 이용해서\n새로운 스탬프를 받아보세요!")
                        .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬을 위해 추가
                    
                    Spacer()
                }
                .padding(.horizontal, 37)
            }
        }
    }
}
