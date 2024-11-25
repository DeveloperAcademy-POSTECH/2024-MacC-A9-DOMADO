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
    @Published var phone: String = "" {
        didSet {
            formatPhoneNumber()
        }
    }
    
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
    
    // MARK: - Phone Number Formatting
    private func formatPhoneNumber() {
        // 숫자만 추출
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // 11자리를 초과하는 입력 방지
        if numbers.count > 11 {
            phone = String(numbers.prefix(11))
            return
        }
        
        // 하이픈 추가 포매팅
        var formattedNumber = ""
        
        if numbers.count > 0 {
            // 앞 3자리
            formattedNumber = String(numbers.prefix(3))
            
            if numbers.count > 3 {
                // 중간 3-4자리
                let middleIndex = numbers.index(numbers.startIndex, offsetBy: 3)
                let middleEndIndex = numbers.index(numbers.startIndex, offsetBy: min(7, numbers.count))
                let middlePart = numbers[middleIndex..<middleEndIndex]
                formattedNumber += "-" + middlePart
                
                if numbers.count > 7 {
                    // 마지막 4자리
                    let lastIndex = numbers.index(numbers.startIndex, offsetBy: 7)
                    let lastPart = numbers[lastIndex..<numbers.endIndex]
                    formattedNumber += "-" + lastPart
                }
            }
        }
        
        // 포매팅된 번호가 현재와 다른 경우에만 업데이트
        if formattedNumber != phone {
            phone = formattedNumber
        }
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
        // 하이픈이 포함된 전화번호 검증
        let phoneRegex = "^010-([0-9]{3,4})-([0-9]{4})$"
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
