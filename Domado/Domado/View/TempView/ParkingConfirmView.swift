//
//  ConfirmParkingView.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import SwiftUI

struct ParkingConfirmView: View {
    
    @StateObject var vm: ParkingConfirmViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
               
                Button {
                    vm.cancelParking()
                } label: {
                    Image(systemName: "xmark")
                }

            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                vm.parkBike()
            } label: {
                Text("바이크 주차하기 ")
            }

        }
        .padding()
    }
}

