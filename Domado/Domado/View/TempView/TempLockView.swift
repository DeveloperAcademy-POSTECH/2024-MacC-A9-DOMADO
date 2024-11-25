//
//  TempLockView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct TempLockView: View {
    
    @StateObject var vm: TempLockViewModel
    
    var body: some View {
        VStack(spacing: 20){
            Text("바이크가 안전하게 잠겨있어요")
            Button {
                vm.showHikeBikeGuide()
            } label: {
                Text("하이바이크로 전환하기")
            }

            Button {
                vm.showUnparkConfirmView()
            } label: {
                Text("바이크 잠금 해제")
            }
        }
        .padding()
    }
}
