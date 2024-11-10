//
//  OnboardingView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject var vm: OnboardingViewModel
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer()
                
                Button {
                    vm.dismissOnboarding()
                } label: {
                    Image(systemName: "xmark")
                }

            }
            .padding(.horizontal)
            Spacer()
            
            Text("온보딩뷰")
            
            Spacer()
            
        }
    }
}
