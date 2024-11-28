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
            // MARK: 추후 삭제
            .overlay(alignment: .topLeading){
                Button {
                    vm.showPaymentGuide()
                } label: {
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .opacity(0)
                }
            }
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
