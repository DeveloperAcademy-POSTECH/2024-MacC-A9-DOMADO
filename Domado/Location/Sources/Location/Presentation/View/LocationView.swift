//
//  SwiftUIView.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import SwiftUI
import MapKit

public struct LocationView: View {
    @ObservedObject private var vm: LocationViewModel
    
    public init(vm: LocationViewModel) {
        self.vm = vm
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Map(position: $vm.position) {
                UserAnnotation()
                
                if let bikeListEntity = vm.bikeList {
                    // Hubs 표시
                    ForEach(bikeListEntity.hubs) { hub in
                        Annotation(
                            hub.hubName,
                            coordinate: CLLocationCoordinate2D(
                                latitude: hub.latitude,
                                longitude: hub.longitude
                            ),
                            anchor: .bottom
                        ) {
                            Button {
                                vm.selectHub(hub)
                            } label: {
                                ZStack {
                                    Image("hubpin", bundle: .module)
                                    
                                    Text("\(hub.totalAvailableBikes)")
                                        .customFont(.button_md_semibold)
                                        .foregroundColor(Color.grayScaleDarker)
                                        .offset(y: -6)
                                }
                            }
                            .scaleEffect(vm.selectedHub?.id == hub.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: vm.selectedHub?.id)
                        }
                    }
                    
                    // HiBikes 표시
                    ForEach(bikeListEntity.hiBikes) { hiBike in
                        Annotation(
                            hiBike.qrCode,
                            coordinate: CLLocationCoordinate2D(
                                latitude: hiBike.latitude,
                                longitude: hiBike.longitude
                            ),
                            anchor: .bottom
                        ) {
                            Button {
                                vm.selectHiBike(hiBike)
                            } label: {
                                ZStack {
                                    Image("hiBikepin", bundle: .module)
                                    
                                    Text(hiBike.homeHubName.hasPrefix("생활관")
                                         ? "생\(hiBike.homeHubName.filter { $0.isNumber })"
                                         : "\(hiBike.homeHubName.prefix(2))")
                                    .customFont(.button_md_semibold)
                                    .foregroundColor(Color.grayScaleDarker)
                                    .offset(x: 6)
                                }
                            }
                            .scaleEffect(vm.selectedHiBike?.id == hiBike.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: vm.selectedHiBike?.id)
                        }
                    }
                }
            }
            .mapStyle(.standard)
            .tint(Color.MylocationMarker)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                vm.clearSelection()
            }
            
            if let hub = vm.selectedHub {
                HubCard(hub: hub)
                    .transition(.move(edge: .top))
            }
            
            if let hiBike = vm.selectedHiBike {
                HiBikeCard(hiBike: hiBike)
                    .transition(.move(edge: .top))
            }
        }
    }
}
