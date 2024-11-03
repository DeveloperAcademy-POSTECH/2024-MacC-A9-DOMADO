//
//  ErrorAlertModifier.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import SwiftUI

// MARK: - ViewModifier
struct ErrorAlertModifier: ViewModifier {
    @ObservedObject var errorState: GlobalErrorState
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $errorState.showError) {
                Alert(
                    title: Text("오류"),
                    message: Text(errorState.currentError?.errorDescription ?? ""),
                    dismissButton: .default(Text("확인")) {
                        errorState.dismiss()
                    }
                )
            }
    }
}

extension View {
    func errorAlert(errorState: GlobalErrorState) -> some View {
        modifier(ErrorAlertModifier(errorState: errorState))
    }
}
