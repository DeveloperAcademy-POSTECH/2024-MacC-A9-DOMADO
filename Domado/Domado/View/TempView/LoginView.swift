//
//  LoginView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20){
            Text("로그인 화면")
            Button {
                vm.login()
            } label: {
                Text("네비게이션")
            }
            
            Button {
                vm.qrCodeScan()
            } label: {
                Text("모달")
            }
            
            Button {
                vm.onBoarding()
            } label: {
                Text("풀스크린")
            }


        }
    }
}
