//
//  Untitled.swift
//  Location
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

struct RideHistoryCell: View {
    var rideDate: String = "24. 10. 19"
    var homeHubName: String = "생활관 18동"
    var rideTime: String = "09:27 -09:41"
    var appliedCoupon: String = "내역없음"
    var paymentMethod: String = "기업은행 **79"
    var fareAmount: String = "3,400"
    
    var body: some View {
        Divider()
            .foregroundStyle(Color.grayScaleLight)
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("하이바이크")
                    .customFont(.button_md_semibold)
                    .foregroundStyle(Color.grayScaleDarker)
                Spacer()
                Text(rideDate)
                    .customFont(.body_sm_regular)
                    .foregroundStyle(Color.grayScaleNormal)
                
            }
            .padding(.bottom, 15)
            VStack(alignment:.leading, spacing: 9) {
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
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 10)
        
        
        
    }
    
}

#Preview {
    RideHistoryCell()
}
