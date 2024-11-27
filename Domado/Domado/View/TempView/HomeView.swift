//
//  HomeView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI
import Core
import MapKit

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    
    var body: some View {
    
        Map(position: $vm.position) {
            UserAnnotation()
        }
        .mapStyle(.standard)
        .overlay(alignment: .bottom) {
            HomeInfoCard {
                print("내정보 쿠폰카드 보여주기")
            } rentAction: {
                vm.rentBikeWithQR()
            }
        }
    }
}
