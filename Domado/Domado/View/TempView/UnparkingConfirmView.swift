//
//  UnparkingConfirmView.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import SwiftUI

struct UnparkingConfirmView: View {
    
    @StateObject var vm: UnparkingConfirmViewModel
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                
                Button {
                    vm.dismissUnparkConfirmView()
                } label: {
                    Image(systemName: "xmark")
                }
                
            }
            
            Spacer()
            
            Button {
                vm.unparkBike()
            } label: {
                Text("바이크 잠금해제")
            }

            
        }
    }
}
