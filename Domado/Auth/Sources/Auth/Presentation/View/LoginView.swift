//
//  SwiftUIView.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//

import SwiftUI

public struct LoginView: View {
    @StateObject private var vm: LoginViewModel
    @FocusState private var focusField: Field?
    
    enum Field {
        case email
        case password
    }
    
    public init(vm: LoginViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                // Top Bar with X button
                HStack {
                    Spacer()
                    Button {
                        vm.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                
                VStack(spacing: 24) {
                    // Title
                    Text("로그인")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("이메일")
                            .foregroundColor(.gray)
                        
                        TextField("이메일을 입력해주세요", text: $vm.email)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .focused($focusField, equals: .email)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("비밀번호")
                            .foregroundColor(.gray)
                        
                        SecureField("비밀번호를 입력해주세요", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .focused($focusField, equals: .password)
                    }
                    
                    // Login Button
                    Button {
                        vm.signIn()
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("로그인")
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(vm.isLoading)
                    .padding(.top, 16)
                    
                    // Sign Up Button
                    Button {
                        vm.navigateToSignUp()
                    } label: {
                        Text("계정이 없으신가요? 회원가입")
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 8)
                    
                    // 안내 문구 추가
                    Text("바이크 대여를 위해서는 로그인이 필요해요")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 32)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .contentShape(Rectangle())
        .onTapGesture {
            focusField = nil
        }
    }
}
