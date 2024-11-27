//
//  Toggle.swift
//  Core
//
//  Created by 고재보 on 11/20/24.
//

import SwiftUI

public struct HibikeToggle: View {
    @Binding var isOn: Bool
    let action: () -> Void
    
    public init(isOn: Binding<Bool>, action: @escaping () -> Void){
        self._isOn = isOn
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(isOn ? .yellow : .white)
                .frame(width: 358, height: 75)

            HStack(spacing: 60) {
                HStack(spacing: 3) {
                    Text("하이바이크로 전환하기")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    
                    helpButton
                }
                
                toggleButton
            }
        }
    }
    
    private var helpButton: some View {
        Button {
            // Sheet navigation logic here
        } label: {
            Image(systemName: "questionmark.circle")
                .fontWeight(.bold)
                .foregroundColor(.interactivePrimary)
        }
    }
    
    private var toggleButton: some View {
        Toggle("", isOn: $isOn)
            .labelsHidden()
            .tint(.interactivePrimary)
            .onChange(of: isOn) { oldValue, newValue in
                action()
            }
    }
}

#Preview {
    VStack {
        HibikeToggle(isOn: .constant(false)) {
            print("토글 상태가 변경되었습니다")
        }
        .padding()
        
        HibikeToggle(isOn: .constant(true)) {
            print("토글 상태가 변경되었습니다")
        }
        .padding()
    }
    .background(Color.gray.opacity(0.5))
}
