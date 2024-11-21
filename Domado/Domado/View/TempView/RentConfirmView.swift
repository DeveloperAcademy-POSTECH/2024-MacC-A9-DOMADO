//
//  RentConfirmView.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import SwiftUI

struct RentConfirmView: View {
    
    @StateObject var vm: RentConfirmViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    vm.cancelRent()
                } label: {
                    Image(systemName: "xmark")
                }

            }
            
            Spacer()
            
            Button {
                vm.rentBike()
            } label: {
                Text("자전거 대여하기")
            }

        }
    }
}
