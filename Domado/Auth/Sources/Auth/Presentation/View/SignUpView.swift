//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/21/24.
//

import SwiftUI

public struct SignUpView: View {
    @StateObject private var vm: SignUpViewModel
    
    
    public init(vm: SignUpViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Title
                Text("회원가입")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("이메일")
                        .fontWeight(.medium)
                    
                    TextField("이메일을 입력해주세요", text: $vm.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    if let error = vm.emailError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                // Password Fields
                VStack(alignment: .leading, spacing: 8) {
                    Text("비밀번호")
                        .fontWeight(.medium)
                    
                    SecureField("비밀번호를 입력해주세요", text: $vm.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.newPassword)
                    
                    SecureField("비밀번호를 다시 입력해주세요", text: $vm.passwordConfirm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.password)
                    
                    if let error = vm.passwordError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                // Name Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("이름")
                        .fontWeight(.medium)
                    
                    TextField("이름을 입력해주세요", text: $vm.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if let error = vm.nameError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                // Phone Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("전화번호")
                        .fontWeight(.medium)
                    
                    TextField("전화번호를 입력해주세요", text: $vm.phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    if let error = vm.phoneError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                // Error Message
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top)
                }
                
                // Sign Up Button
                Button(action: {
                    
                    vm.signUp()
                    
                }) {
                    if vm.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("가입하기")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .disabled(vm.isLoading)
            }
            .padding()
        }
        .alert("회원가입 완료", isPresented: $vm.isSignUpSuccess) {
            Button("확인") {
                vm.backToLogin()
            }
        } message: {
            Text("회원가입이 성공적으로 완료되었습니다.")
        }
    }
}
