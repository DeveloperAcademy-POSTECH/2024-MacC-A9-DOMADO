//
//  RideCompleteView.swift
//  Payment
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

struct RideCompleteView: View {
    //        @Environment(\.dismiss) private var dismiss
    
    //    var rideDate: String = "24. 10. 19"
    var homeHubName: String = "생활관 18동"
    var rideTime: String = "09:27 - 09:41"
    var appliedCoupon: String = "내역없음"
    var paymentMethod: String = "기업은행 **79"
    var fareAmount: String = "5,600"
    var rideDuration: String = "30 : 21"
    var rideDistance: String = "13"
    
    
    var body: some View {
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
                        //                        dismiss()
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
                    Text("\(fareAmount)원")
                        .customFont(.amount_lg_bold)
                        .foregroundStyle(Color.grayScaleDarker)
                        .padding(.bottom, 29)
                    
                    VStack(alignment: .leading, spacing: 15){
                        
                        HStack(spacing: 10) {
                            Text("반납 지역")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(homeHubName)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("이용 시간")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(rideTime)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("쿠폰 내역")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(appliedCoupon)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("결제 수단")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text(paymentMethod)
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                        HStack(spacing: 10) {
                            Text("금액")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleLightActive)
                            Text("\(fareAmount)원")
                                .customFont(.body_sm_regular)
                                .foregroundStyle(Color.grayScaleNormal)
                        }
                    }
                    .padding(.bottom, 28)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.grayScaleWhite)
                        .frame(height: 91)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
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
                                        //                                            .background(Color.red)
                                        
                                        Text(rideDuration)
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
                                        //                                            .background(Color.red)
                                        
                                        Text("\(rideDistance)km")
                                            .customFont(.station_lg_bold)
                                            .foregroundStyle(Color.grayScaleDarker)
                                    }
                                }
                                
                            }
                                .padding(.horizontal, 32)
                        )
                        .padding(.bottom, 25)
                    
                    //                    CouponBook()
                    Spacer()
                }
                .padding(.horizontal, 37)
                
            }
            
        }
    }
}

#Preview {
    RideCompleteView()
}
