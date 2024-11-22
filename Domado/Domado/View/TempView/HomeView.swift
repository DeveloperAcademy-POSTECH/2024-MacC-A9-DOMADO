//
//  HomeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    
    var body: some View {
        VStack{
            
            Spacer()
            
            HStack{
                
                Button {
                    
                } label: {
                    Text("내정보")
                }

                
                Button {
                    vm.rentBikeWithQR()
                } label: {
                    Text("QR 찍고 자전거 대여하기")
                }

            }
        }
        
    }
}
