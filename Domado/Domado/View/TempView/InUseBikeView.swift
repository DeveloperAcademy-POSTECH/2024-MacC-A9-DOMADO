//
//  InUseBikeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct InUseBikeView: View {
    
    @StateObject var vm: InUseBikeViewModel
    
    var body: some View {
        VStack{
            Text("대충 지도")
            
            Spacer()
            
            Button {
                vm.parkBike()
            } label: {
                Text("바이크 주차하기")
            }
        }
        .padding()
    }
}
