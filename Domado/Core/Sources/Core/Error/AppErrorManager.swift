//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/25/24.
//

import SwiftUI

/// 앱 전체에서 발생하는 에러를 관리하고 표시하는 클래스입니다.
///
/// 이 클래스는 `ObservableObject`를 준수하여 SwiftUI 환경에서
/// 에러 상태의 변화를 관찰하고 UI를 자동으로 업데이트할 수 있게 합니다.
///
/// ## 사용 예제:
///
/// ```swift
/// // AppDelegate.swift 또는 앱의 main SwiftUI 파일에서
/// @main
/// struct MyApp: App {
///     @StateObject private var errorManager = AppErrorManager()
///
///     var body: some Scene {
///         WindowGroup {
///             LoginView()
///                 .environment(\.errorHandler, errorManager)
///         }
///     }
/// }
///
/// // AuthService.swift
/// class AuthService {
///     func login(email: String, password: String) async throws -> User {
///         // 실제 네트워크 요청 구현
///         // 오류 발생 시 throw
///         throw AuthError.invalidCredentials
///     }
/// }
///
/// // LoginViewModel.swift
/// class LoginViewModel: ObservableObject {
///     @Published var email = ""
///     @Published var password = ""
///     @Published var isLoading = false
///     @Environment(\.errorHandler) private var errorHandler
///
///     private let authService: AuthService
///
///     init(authService: AuthService = AuthService()) {
///         self.authService = authService
///     }
///
///     func login() {
///         isLoading = true
///         Task {
///             do {
///                 let user = try await authService.login(email: email, password: password)
///                 await MainActor.run {
///                     isLoading = false
///                     // 로그인 성공 처리 (예: 사용자 정보 저장, 화면 전환 등)
///                 }
///             } catch {
///                 await MainActor.run {
///                     isLoading = false
///                     errorHandler.handle(error)
///                 }
///             }
///         }
///     }
/// }
///
/// // LoginView.swift
/// struct LoginView: View {
///     @StateObject private var viewModel = LoginViewModel()
///
///     var body: some View {
///         VStack {
///             TextField("Email", text: $viewModel.email)
///                 .textFieldStyle(RoundedBorderTextFieldStyle())
///             SecureField("Password", text: $viewModel.password)
///                 .textFieldStyle(RoundedBorderTextFieldStyle())
///             Button(action: viewModel.login) {
///                 if viewModel.isLoading {
///                     ProgressView()
///                 } else {
///                     Text("Login")
///                 }
///             }
///             .disabled(viewModel.isLoading)
///         }
///         .padding()
///         .handleGlobalErrors()
///     }
/// }
///
public class AppErrorManager: ObservableObject, GlobalErrorHandler {
    /// 현재 표시 중인 에러입니다. `nil`이면 에러가 없음을 의미합니다.
    @Published public var currentError: AppError?
    
    public init() {}
    
    /// 주어진 에러를 처리합니다.
    ///
    /// - Parameter error: 처리할 Error 객체
    /// - Returns: 항상 `nil`을 반환합니다. 모든 에러를 내부적으로 처리하기 때문입니다.
    public func handle(_ error: Error) -> AppError? {
        let appError: AppError
        if let businessError = error as? BusinessError {
            appError = businessError
        } else if let knownError = error as? AppError {
            appError = knownError
        } else {
            appError = UnknownError(error)
        }
        
        handleGlobalError(appError)
        return nil  // 에러가 완전히 처리되었음을 나타냅니다.
    }
    
    /// 글로벌 수준에서 AppError를 처리합니다.
    ///
    /// - Parameter error: 처리할 AppError 객체
    func handleGlobalError(_ error: AppError) {
        // TODO: 에러 로깅 구현
        // logError(error)
        
        self.showError(error)
        
        // TODO: 에러 리포팅 서비스 구현
        // sendErrorReport(error)
    }
    
    /// 에러를 표시합니다.
    ///
    /// - Parameter error: 표시할 AppError 객체
    public func showError(_ error: AppError) {
        self.currentError = error
    }
    
    /// 현재 표시 중인 에러를 제거합니다.
    public func dismissError() {
        self.currentError = nil
    }
    
    // TODO: 에러 로깅 메서드 구현
    // private func logError(_ error: AppError) {
    //     print("Global error occurred: \(error.errorDescription) (Code: \(error.errorCode))")
    // }
    
    // TODO: 에러 리포팅 메서드 구현
    // private func sendErrorReport(_ error: AppError) {
    //     print("Error report sent for: \(error.errorDescription)")
    // }
}
