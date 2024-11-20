//
//  SlideButton.swift
//  Core
//
//  Created by 고재보 on 11/19/24.
//

//
//  SlideButton.swift
//  Core
//
//  Created by 고재보 on 11/19/24.
//

import SwiftUI

public struct SlideButton: View {
    @State private var offset: CGFloat = 0
    @State private var isDragging = false
    @State private var unlocked = false
    
    let title: String
    let slideIcon: String
    let lockIcon: String
    let action: () -> Void
    
    public init(
        title: String = "바이크 주차하기 →",
        slideIcon: String = "bicycle",
        lockIcon: String = "lock.fill",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.slideIcon = slideIcon
        self.lockIcon = lockIcon
        self.action = action
    }
    
    // MARK: - Helper Methods
    
    private func generateHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    // MARK: - Gesture Handlers
    
    private func handleDragChange(value: DragGesture.Value, maxWidth: CGFloat) {
        let newOffset = max(0, min(value.translation.width, maxWidth - 60))
        let progress = newOffset / (maxWidth - 60)
        
        if Int(progress * 4) != Int(offset / (maxWidth - 60) * 4) {
            generateHapticFeedback(style: .light)
        }
        
        offset = newOffset
        isDragging = true
    }
    
    private func handleDragEnd(maxWidth: CGFloat) {
        isDragging = false
        
        if offset > maxWidth * 0.8 {
            completeSlide(maxWidth: maxWidth)
        } else {
            resetSlide()
        }
    }
    
    private func completeSlide(maxWidth: CGFloat) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            offset = maxWidth - 60
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
    }
    
    private func resetSlide() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            offset = 0
        }
        generateHapticFeedback(style: .medium)
    }
    
    // MARK: - View Components
    
    private var backgroundLayer: some View {
        Capsule()
            .fill(Color.lightBlue)
    }
    
    private var progressLayer: some View {
        Capsule()
            .fill(Color.white.opacity(0.3))
            .frame(width: max(offset + 70, 0))
            .animation(.easeOut(duration: 0.2), value: offset)
    }
    
    private var titleAndLockIcon: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.darkBlue)
                .font(.system(size: 16, weight: .bold))
                .opacity(isDragging ? 0.1 : 1)
                .animation(.easeInOut(duration: 0.2), value: unlocked)
                .padding(.leading, 90)
            
            Spacer()
            
            Circle()
                .fill(Color.darkBlue)
                .frame(width: 70, height: 70)
                .overlay(
                    Image(systemName: unlocked ? "checkmark" : lockIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.lightBlue)
                        .padding(20)
                )
                .padding(.trailing, 2)
        }
    }
    
    private var slideButton: some View {
        Circle()
            .fill(isDragging ? Color.deepBlue.opacity(0.9) : Color.deepBlue)
            .frame(width: 70, height: 70)
            .shadow(radius: 3, x: 2, y: 2)
            .overlay(
                Image(systemName: slideIcon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(18)
            )
            .offset(x: offset)
            .animation(isDragging ? nil : .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: offset)
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                backgroundLayer
                progressLayer
                titleAndLockIcon
                
                slideButton
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                handleDragChange(value: value, maxWidth: geometry.size.width)
                            }
                            .onEnded { _ in
                                handleDragEnd(maxWidth: geometry.size.width)
                            }
                    )
            }
        }
        .frame(height: 75)
    }
}

// MARK: - Preview

#Preview("Slide Button Examples") {
    VStack(spacing: 20) {
        // 자전거 대여 버튼
        SlideButton(
            title: "바이크 잠금해제 →",
            slideIcon: "bicycle",
            lockIcon: "lock.open"
        ) {
            print("바이크가 대여되었습니다!")
        }
        .frame(width: 300)
        
        // 자전거 반납 버튼
        SlideButton(
            title: "바이크 주차하기 →",
            slideIcon: "bicycle",
            lockIcon: "lock.fill"
        ) {
            print("바이크가 반납되었습니다!")
        }
        .frame(width: 300)
        
        // 결제 버튼
        SlideButton(
            title: "요금 결제하기 →",
            slideIcon: "creditcard",
            lockIcon: "faxmachine"
        ) {
            print("결제가 완료되었습니다!")
        }
        .frame(width: 300)
    }
    .padding()
}
