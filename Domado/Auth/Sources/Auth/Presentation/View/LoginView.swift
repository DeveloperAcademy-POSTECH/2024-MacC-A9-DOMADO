//
//  SwiftUIView.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//

import SwiftUI

public struct LoginView: View {
    @StateObject private var vm: LoginViewModel
    
    public init(vm: LoginViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
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
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("비밀번호")
                    .foregroundColor(.gray)
                
                SecureField("비밀번호를 입력해주세요", text: $vm.password)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
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
                // Handle sign up navigation
            } label: {
                Text("계정이 없으신가요? 회원가입")
                    .foregroundColor(.blue)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
    }
}
