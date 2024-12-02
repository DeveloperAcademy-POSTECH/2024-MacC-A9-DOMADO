//
//  SwiftUIView.swift
//  Core
//
//  Created by yoomin on 11/22/24.
//

import SwiftUI

public struct CouponBook: View {
    var width: CGFloat = 330
    var height: CGFloat = 234
    var title: String = "하이바이크를 대여해서\n새로운 스티커가 추가되었어요!"
    var subtitle: String = "4개의 하이를 더 모아 하이파이브를 해보세요!\n자전거 이용권을 받을 수 있어요."
    
    public init(title: String){
        self.title = title
    }
    
    public var body: some View {
        Rectangle()
            .fill(Color.hibikeYellowBack)
            .overlay(
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .customFont(.headline_md)
                        .foregroundStyle(Color.brownNormal)
                        .padding(.bottom, 8)
                    
                    Text(subtitle)
                        .customFont(.caption_md_regular)
                        .foregroundStyle(Color.brownNormal)
                        .padding(.bottom, 20)
                    
                    ZStack(alignment: .leading){
                        ForEach(0..<5) { index in
                            ZStack{
                                Circle()
                                    .fill(Color.hibikeYellowLight)
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Text("\(index + 1)회")
                                            .foregroundStyle(Color.brownLightActive)
                                            .customFont(.body_md_regular)
                                    )
                                if index == 0 {
                                    Image("hiBike")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 52)
                                        .offset(y: -2)
                                }
                            }
                            .offset(x: CGFloat(index * 60), y: index % 2 == 0 ? 36 : 0)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                }
                    .padding(18)
                
            )
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .frame(width: width, height: height)
        
    }
}

