//
//  SwiftUIView.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import SwiftUI
import Core
import MapKit

public struct ActiveRentalView: View {
    
    @StateObject private var vm: ActiveRentViewModel
    
    public init(vm: ActiveRentViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        ZStack{
            Map(position: $vm.position) {
                UserAnnotation()
            }
            .mapStyle(.standard)
            .overlay(alignment: .bottom) {
                BikeInfoCard(remainingTime: vm.remainingTime, batteryLevel: vm.batteryLevel, isParked: vm.isParked) {
                    // 자전거 주차하기
                    vm.parkBike()
                }
                .padding()
            }
        }
    }
}
