//
//  HiBikeGuideView.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import SwiftUI

struct HiBikeGuideView: View {
    
    @StateObject var vm: HiBikeGuideViewModel
    
    var body: some View {
        
        VStack{
            
            HStack{
                Spacer()
                Button {
                    vm.dismissGuide()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            Text("하이 바이크 가이드")
        }
        .padding()
    }
}

