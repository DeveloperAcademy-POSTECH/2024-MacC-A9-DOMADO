//
//  BikeInfoCard.swift
//  Core
//
//  Created by 고재보 on 11/20/24.
//

import SwiftUI

struct BikeInfoCard: View {
    let remainingTime: String
    let batteryLevel: String
    let isParked: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(isParked ? .white : Color.deepBlue)
                .frame(width: 358, height: 178)
            
            VStack(spacing: 24) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("이용 시간")
                            .font(.system(size: 15))
                            .foregroundColor(isParked ? .gray : .white.opacity(0.8))
                        
                        HStack{
                            Image(systemName: "clock.fill")
                                .foregroundColor(isParked ? .black.opacity(0.6) : .white.opacity(0.6))
                            
                            Text(remainingTime)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(isParked ? .black : .white)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("배터리 상태")
                            .font(.system(size: 15))
                            .foregroundColor(isParked ? .gray : .white.opacity(0.8))
                        
                        HStack(spacing: 4) {
                            Image(systemName: "battery.75")
                                .foregroundColor(isParked ? .black.opacity(0.6) : .white.opacity(0.6))
                            
                            Text(batteryLevel)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(isParked ? .black : .white)
                            
                            Text("주행할 수 있어요")
                                .font(.system(size: 17))
                                .foregroundColor(isParked ? .black : .white)
                                .opacity(0.6)
                        }
                    }
                }
                HStack {
                    Spacer()
                    PrimaryButton(
                        title: isParked ? "바이크 잠금해제" : "바이크 주차하기",
                        icon: isParked ? "bicycle" : "lock.fill",
                        backgroundColor: isParked ? .deepBlue : .white,
                        fontColor: isParked ? .white : .black,
                        iconColor: isParked ? .white : .gray,
                        action: action
                    )
                }
            }
            .padding(30)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        BikeInfoCard(
            remainingTime: "52:21",
            batteryLevel: "21km",
            isParked: true
        ) {
            print("바이크가 잠금해제되었습니다!")
        }
        .frame(height: 180)
        
        BikeInfoCard(
            remainingTime: "30:21",
            batteryLevel: "21km",
            isParked: false
        ) {
            print("바이크가 주차되었습니다!")
        }
        .frame(height: 180)
    }
    
    .padding()
    .background(Color.gray.opacity(0.5))

}
