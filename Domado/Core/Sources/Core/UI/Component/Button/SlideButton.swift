//
//  SlideButton.swift
//  Core
//
//  Created by 고재보 on 11/19/24.
//

import SwiftUI

public struct BikeUnlockButton: View {
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    @State private var unlocked = false
    
    let title: String
    let lockIcon: String
    let action: () -> Void
    
    public init(
        title: String = "바이크 주차하기 →",
        lockIcon: String = "lock.fill",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.lockIcon = lockIcon
        self.action = action
    }
    
    private func generateHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.blue.opacity(0.1))
                
                Capsule()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: max(offset + 56, 0))
                    .animation(.easeOut(duration: 0.2), value: offset)
                
                HStack(spacing: 13) {
                    Spacer()
                        .frame(width: 56)
                    
                    Text(title)
                        .foregroundColor(Color(UIColor.systemGray2))
                        .font(.system(size: 18, weight: .medium))
                        .opacity(unlocked ? 0 : 1)
                        .animation(.easeInOut(duration: 0.2), value: unlocked)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: unlocked ? "checkmark" : lockIcon)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.gray)
                                .padding(15)
                        )
                        .padding(.trailing, 2)
                }
                .padding(.horizontal, 2)
                
                Circle()
                    .fill(isDragging ? Color.blue.opacity(0.8) : Color.blue)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "bicycle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(6)
                    )
                    .offset(x: offset)
                    .animation(isDragging ? nil : .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newOffset = max(0, min(value.translation.width, geometry.size.width - 60))
                                
                                let progress = newOffset / (geometry.size.width - 60)
                                if Int(progress * 4) != Int(offset / (geometry.size.width - 60) * 4) {
                                    generateHapticFeedback(style: .light)
                                }
                                
                                offset = newOffset
                                isDragging = true
                            }
                            .onEnded { value in
                                isDragging = false
                                
                                if offset > geometry.size.width * 0.8 {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                                        offset = geometry.size.width - 60
                                        unlocked = true
                                    }
                                    generateHapticFeedback(style: .heavy)
                                    action()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            offset = 0
                                            unlocked = false
                                        }
                                    }
                                } else {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                                        offset = 0
                                    }
                                    generateHapticFeedback(style: .medium)
                                }
                            }
                    )
            }
        }
        .frame(height: 60)
    }
}

#Preview("Bike Unlock Button") {
    VStack(spacing: 1) {
        BikeUnlockButton(
            title: "바이크 대여하기 →",
            lockIcon: "lock.open"
        ) {
            print("바이크가 주차되었습니다!")
        }
        .frame(width: 300)
    }
}
