//
//  Toggle.swift
//  Core
//
//  Created by 고재보 on 11/20/24.
//

import SwiftUI

public struct HibikeToggle: View {
    @Binding var isOn: Bool
    let hiBikeAction: () -> Void
    let helpAction: () -> Void
    
    public init(isOn: Binding<Bool>, hibikeAction: @escaping () -> Void, helpAction: @escaping () -> Void){
        self._isOn = isOn
        self.hiBikeAction = hibikeAction
        self.helpAction = helpAction
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
            helpAction()
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
                hiBikeAction()
            }
    }
}
