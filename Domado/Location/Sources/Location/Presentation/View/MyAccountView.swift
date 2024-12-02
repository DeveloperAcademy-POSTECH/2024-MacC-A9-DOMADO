//
//  MuAccountView.swift
//  Location
//
//  Created by yoomin on 11/28/24.
//

import SwiftUI
import Core

public struct MyAccountView: View {
    
    @StateObject private var vm: MyAccountViewModel
    
    public init(vm: MyAccountViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ZStack{
            Color.grayScaleLight.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 네비게이션 타이틀과 X 버튼
                HStack {
                    Spacer()
                        .frame(width: 21)
                    Spacer()
                    
                    Text("내 정보 보기")
                        .customFont(.headline_sm)
                        .foregroundStyle(Color.grayScaleDarker)
                    
                    Spacer()
                    
                    Button {
                        vm.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.interactivePrimary)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 23)
                .padding(.top, 11)
                .padding(.bottom, 8)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) { // 제일 바깥 -> 스크롤뷰 28
                        VStack(spacing: 0){
                            HStack(spacing: 0){
                                Button {
                                    // 내 쿠폰
                                } label: {
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 159, height: 212) // 나중에 패딩으로 바꿔야할지도..
                                        .foregroundStyle(Color.grayScaleWhite)
                                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                                        .overlay (
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("내 쿠폰")
                                                    .customFont(.batterynumber)
                                                    .foregroundStyle(Color.grayScaleDarker)
                                                    .padding(.bottom, 10)
                                                ZStack{
                                                    Image("coupon", bundle: .module)
                                                    Image("char1", bundle: .module)
                                                        .offset(x: 20, y: 40)
                                                        .modifier(BouncingAnimation(isReversed: false, delay: 2))
                                                }
                                            }
                                        )
                                }
                                .padding(.trailing, 16)
                                
                                Button {
                                    // 내 쿠폰
                                } label: {
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 159, height: 212)
                                        .foregroundStyle(Color.grayScaleWhite)
                                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                                        .overlay (
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("결제 관리")
                                                    .customFont(.batterynumber)
                                                    .foregroundStyle(Color.grayScaleDarker)
                                                    .padding(.bottom, 10)
                                                ZStack{
                                                    Image("cash", bundle: .module)
                                                    Image("char2", bundle: .module)
                                                        .offset(y: 10)
                                                        .modifier(BouncingAnimation(isReversed: false, delay: 1.5))
                                                }
                                            }
                                        )
                                }
                            }
                            .padding(.bottom, 20)
                            
                            Button {
                                // 하이바이크 이용방법
                            } label: {
                                RoundedRectangle(cornerRadius: 25)
                                    .overlay(
                                        HStack(spacing: 0){
                                            Text("하이바이크 이용방법")
                                                .customFont(.batterynumber)
                                                .foregroundStyle(Color.grayScaleDarker)
                                            Spacer()
                                        }
                                            .padding(.horizontal, 24)
                                    )
                                    .frame(width: 334, height: 83)
                                    .foregroundStyle(Color.grayScaleWhite)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                                    .padding(.bottom, 20)
                            }
                            
                        }
                        .padding(.horizontal, 12)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color.grayScaleWhite)
                            
                                .frame(width: 366)
                                .frame(maxWidth: .infinity)
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                                .padding(.horizontal, 12)
                            
                            VStack(alignment:.leading, spacing: 0) {
                                HStack(spacing: 0){
                                    Text("이용기록")
                                        .padding(.top, 24)
                                        .padding(.bottom, 18)
                                    Spacer()
                                }
                                
                                // 이용기록
                                RideHistoryCell(
                                        rideDate: "24. 10. 19",
                                        homeHubName: "생활관 18동",
                                        rideTime: "09:27 - 10:55",
                                        appliedCoupon: "30분 무료 이용권",
                                        paymentMethod: "기업은행 **79",
                                        fareAmount: "3,400"
                                    )
                                    RideHistoryCell(
                                        rideDate: "24. 10. 18",
                                        homeHubName: "박태준학술정보관",
                                        rideTime: "14:15 - 14:32",
                                        appliedCoupon: "내역 없음",
                                        paymentMethod: "기업은행 **79",
                                        fareAmount: "2,800"
                                    )
                                    RideHistoryCell(
                                        rideDate: "24. 10. 17",
                                        homeHubName: "중앙도서관",
                                        rideTime: "11:05 - 11:28",
                                        appliedCoupon: "내역 없음",
                                        paymentMethod: "카카오페이",
                                        fareAmount: "2,400"
                                    )
                                    RideHistoryCell(
                                        rideDate: "24. 10. 15",
                                        homeHubName: "학생회관",
                                        rideTime: "16:30 - 17:05",
                                        appliedCoupon: "내역 없음",
                                        paymentMethod: "카카오페이",
                                        fareAmount: "1,900"
                                    )
                                    RideHistoryCell(
                                        rideDate: "24. 10. 14",
                                        homeHubName: "정문",
                                        rideTime: "08:45 - 09:10",
                                        appliedCoupon: "내역 없음",
                                        paymentMethod: "카카오페이",
                                        fareAmount: "2,900"
                                    )
                            }
                            .padding(.horizontal, 42)
                        }
                    }
                    .padding(.top, 14)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
}

// 애니메이션 적용
struct BouncingAnimation: ViewModifier {
    let isReversed: Bool
    let delay: Double
    @State private var isAnimating = false
    
    init(isReversed: Bool = false, delay: Double = 0) {
        self.isReversed = isReversed
        self.delay = delay
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? (isReversed ? 9 : -8) : 0)
            .animation(
                Animation.easeInOut(duration: 1.3)
                    .repeatForever()
                    .delay(delay),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}
