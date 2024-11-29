//
//  HomeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI
import Core
import MapKit
import Location

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    @StateObject var locationViewModel: LocationViewModel
    
    var body: some View {
        LocationView(vm: locationViewModel)
            .mapStyle(.standard)
            .overlay {
                if vm.showMyAccountCard {
                    Color.black.opacity(0.01)  // 거의 투명하게
                        .onTapGesture {
                            vm.showMyAccountCard = false
                        }
                }
            }
            .overlay(alignment: .top) {
                if vm.showMyAccountCard {
                    MyAccountCard(showMYAccountView: vm.showInfoCard)
                        .transition(.move(edge: .top))
                        .animation(.spring(), value: vm.showMyAccountCard)
                }
            }
            .overlay(alignment: .bottom) {
                HomeInfoCard {
                    vm.showMyAccountCard = true
                } rentAction: {
                    vm.rentBikeWithQR()
                }
            }
    }
}
