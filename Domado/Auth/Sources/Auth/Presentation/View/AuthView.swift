//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/20/24.
//


import SwiftUI

public struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel
    
    public init(vm: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        VStack {
            switch viewModel.authState {
            case .idle:
                loginForm
            case .authenticating:
                ProgressView("인증중...")
            case .authenticated:
                Text("인증됨")
            case .error(let error):
                Text("오류: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    private var loginForm: some View {
        VStack {
            
        }
    }
}
