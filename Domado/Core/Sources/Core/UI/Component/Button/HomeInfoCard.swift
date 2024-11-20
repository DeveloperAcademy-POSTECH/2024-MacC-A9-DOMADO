//
//  HomeInfoCard.swift
//  Core
//
//  Created by 고재보 on 11/20/24.
//

import SwiftUI


struct HomeInfoCard: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(width: 358, height: 103)
            
            HStack(spacing: 20) {
                HStack(spacing: 1){
                    Image(systemName: "rectangle.bottomthird.inset.filled")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)

                    Text("내 정보")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 2)
                        .fontWeight(.bold)

                }
                    
                    PrimaryButton(
                        title: "QR찍고 \n 자전거 대여하기",
                        icon: "bicycle",
                        backgroundColor: .interactivePrimary,
                        fontColor: .white,
                        iconColor: .white,
                        action: {}
                    )
                    
                }
            }
            
        }
    }


#Preview {
    HStack{
        HomeInfoCard()
    }
    .frame(width: 1000, height: 500)
    .background(Color.gray.opacity(0.5))
}
