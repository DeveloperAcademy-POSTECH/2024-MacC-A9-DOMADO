//
//  File.swift
//  Rent
//
//  Created by 이종선 on 12/3/24.
//

import SwiftUI
import CodeScanner

struct DirectCodeInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var code: String = ""
    @State private var currentIndex: Int = 0
    @FocusState private var isTextFieldFocused: Bool
    let onComplete: (String) -> Void
    
    var isValidCode: Bool {
        code.count == 6
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 닫기 버튼
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 21))
                        .foregroundColor(.blue)
                        .padding(8)
                }
                .padding(.trailing, 15)
                .padding(.top, 15)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // 안내 텍스트
                    VStack(alignment: .leading, spacing: 8) {
                        Text("코드 번호를 입력해주세요")
                            .customFont(.headline_lg)
                        
                        Text("자전거에 부착된 코드 번호 6자리를\n입력해주세요")
                            .customFont(.body_md_regular)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 코드 입력 필드
                    HStack(spacing: 12) {
                        ForEach(0..<6, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(currentIndex == index ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                                    .frame(width: 52, height: 64)
                                
                                if index < code.count {
                                    Text(String(code[code.index(code.startIndex, offsetBy: index)]))
                                        .customFont(.headline_lg)
                                }
                            }
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        isTextFieldFocused = true
                    }
                }
            }
            
            // 숨겨진 텍스트 필드
            TextField("", text: $code)
                .keyboardType(.numberPad)
                .focused($isTextFieldFocused)
                .onChange(of: code) { newValue in
                    let filtered = String(newValue.filter { $0.isNumber }.prefix(6))
                    if filtered != newValue {
                        code = filtered
                    }
                    currentIndex = code.count
                }
                .opacity(0)
            
            // 확인 버튼
            Button {
                onComplete(code)
                dismiss()
            } label: {
                Text("확인")
                    .customFont(.button_lg_bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(isValidCode ? Color.blue : Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .disabled(!isValidCode)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isTextFieldFocused = true
            }
        }
    }
}
