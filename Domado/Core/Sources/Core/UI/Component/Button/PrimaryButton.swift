//
//  PrimaryButton.swift
//  Core
//
//  Created by 고재보 on 11/19/24.
//


import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let icon: String?
    let backgroundColor: Color
    let fontColor: Color
    let iconColor: Color
    
    public init(
        title: String,
        icon: String? = nil,
        backgroundColor: Color = .blue,
        fontColor: Color = .white,
        iconColor: Color = .white,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
        self.iconColor = iconColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Rectangle()
                .frame(width: 210, height: 70)
                .foregroundColor(backgroundColor)
                .cornerRadius(62)
                .overlay {
                    HStack(spacing: 20) {
                        if let icon = icon {
                            Image(systemName: icon)
                                .foregroundColor(iconColor)
                                .font(.title2)
                        }
                        Text(title)
                            .foregroundColor(fontColor)
                            .fontWeight(.semibold)
                    }
                }
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PrimaryButton(
                title: "바이크 주차하기",
                icon: "lock.fill",
                backgroundColor: .white,
                fontColor: .black,
                iconColor: .gray,
                action: {}
            )
            
            PrimaryButton(
                title: "바이크 잠금해제",
                icon: "bicycle",
                backgroundColor: .blue,
                fontColor: .white,
                iconColor: .white,
                action: {}
            )
        }
        .padding()
    }
}
