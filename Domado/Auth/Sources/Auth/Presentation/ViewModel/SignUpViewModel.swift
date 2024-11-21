//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/21/24.
//

import Foundation
import Core

@MainActor
public class SignUpViewModel: ObservableObject {
    private let authUseCase: AuthUseCase
    private let router: Routing
    
    // Form fields
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    @Published var name: String = ""
    @Published var phone: String = ""
    
    // Validation states
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var nameError: String?
    @Published var phoneError: String?
    
    // View states
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccess: Bool = false
    
    public init(authUseCase: AuthUseCase, router: Routing) {
        self.authUseCase = authUseCase
        self.router = router 
    }
    
    // MARK: - Validation Methods
    private func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isValid = emailPred.evaluate(with: email)
        
        if email.isEmpty {
            emailError = "이메일을 입력해주세요."
        } else if !isValid {
            emailError = "올바른 이메일 형식이 아닙니다."
        } else {
            emailError = nil
        }
        
        return emailError == nil
    }
    
    private func validatePassword() -> Bool {
        if password.isEmpty {
            passwordError = "비밀번호를 입력해주세요."
        } else if password.count < 8 {
            passwordError = "비밀번호는 8자 이상이어야 합니다."
        } else if password != passwordConfirm {
            passwordError = "비밀번호가 일치하지 않습니다."
        } else {
            passwordError = nil
        }
        
        return passwordError == nil
    }
    
    private func validateName() -> Bool {
        if name.isEmpty {
            nameError = "이름을 입력해주세요."
        } else if name.count < 2 {
            nameError = "이름은 2자 이상이어야 합니다."
        } else {
            nameError = nil
        }
        
        return nameError == nil
    }
    
    private func validatePhone() -> Bool {
        let phoneRegex = "^01([0-9])-?([0-9]{3,4})-?([0-9]{4})$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phonePred.evaluate(with: phone)
        
        if phone.isEmpty {
            phoneError = "전화번호를 입력해주세요."
        } else if !isValid {
            phoneError = "올바른 전화번호 형식이 아닙니다."
        } else {
            phoneError = nil
        }
        
        return phoneError == nil
    }
    
    // MARK: - Form Validation
    func validateForm() -> Bool {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        let isNameValid = validateName()
        let isPhoneValid = validatePhone()
        
        return isEmailValid && isPasswordValid && isNameValid && isPhoneValid
    }
    
    // MARK: - Sign Up Method
    func signUp() {
        guard validateForm() else { return }
        Task { [weak self, authUseCase] in
            guard let self else { return }
            
            handleLoading(true)
            errorMessage = nil
            
            do {
                try await authUseCase.signUp(
                    email: email,
                    password: password,
                    name: name,
                    phone: phone
                )
                isSignUpSuccess = true
            } catch {
                errorMessage = error.localizedDescription
            }
            
            handleLoading(false)
        }
    }
    
    func resetFields() {
        email = ""
        password = ""
        passwordConfirm = ""
        name = ""
        phone = ""
        errorMessage = nil
        emailError = nil
        passwordError = nil
        nameError = nil
        phoneError = nil
    }
    
    private func handleLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    func backToLogin() {
        router.navigateBack()
    }
    
}
