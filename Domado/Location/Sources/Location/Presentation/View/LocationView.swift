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
    @State private var showZoomWarning = false
    
    public init(vm: LocationViewModel) {
        self.vm = vm
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Map(position: $vm.position, interactionModes: [.pan, .zoom]) {
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
                                withAnimation(.spring(response: 0.3)) {
                                    vm.selectHub(hub)
                                }
                            } label: {
                                ZStack {
                                    Image("hubpin", bundle: .module)
                                        .frame(width: 44, height: 44) // 터치 영역 확보
                                    
                                    Text("\(hub.totalAvailableBikes)")
                                        .customFont(.button_md_semibold)
                                        .foregroundColor(Color.grayScaleDarker)
                                        .offset(y: -6)
                                }
                                .contentShape(Rectangle()) // 전체 영역을 터치 가능하게
                            }
                            .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                            .scaleEffect(vm.selectedHub?.id == hub.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: vm.selectedHub?.id)
                            .highPriorityGesture(TapGesture().onEnded {
                                withAnimation(.spring(response: 0.3)) {
                                    vm.selectHub(hub)
                                }
                            })
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
                                withAnimation(.spring(response: 0.3)) {
                                    vm.selectHiBike(hiBike)
                                }
                            } label: {
                                ZStack {
                                    Image("hiBikepin", bundle: .module)
                                        .frame(width: 44, height: 44) // 터치 영역 확보
                                    
                                    Text(hiBike.homeHubName.hasPrefix("생활관")
                                         ? "생\(hiBike.homeHubName.filter { $0.isNumber })"
                                         : "\(hiBike.homeHubName.prefix(2))")
                                    .customFont(.button_md_semibold)
                                    .foregroundColor(Color.grayScaleDarker)
                                    .offset(x: 6)
                                }
                                .contentShape(Rectangle()) // 전체 영역을 터치 가능하게
                            }
                            .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                            .scaleEffect(vm.selectedHiBike?.id == hiBike.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: vm.selectedHiBike?.id)
                            .highPriorityGesture(TapGesture().onEnded {
                                withAnimation(.spring(response: 0.3)) {
                                    vm.selectHiBike(hiBike)
                                }
                            })
                        }
                    }
                }
            }
            .onMapCameraChange { context in
                let isZoomedOutTooMuch = context.region.span.latitudeDelta > 0.1
                
                if isZoomedOutTooMuch {
                    withAnimation {
                        showZoomWarning = true
                        // 줌 레벨 제한
                        vm.resetToDefaultZoom(center: context.region.center)
                    }
                } else {
                    showZoomWarning = false
                    let newLocation = context.region.center
                    vm.fetchBikes(latitude: newLocation.latitude, longitude: newLocation.longitude)
                }
            }
            .mapStyle(.standard)
            .tint(Color.MylocationMarker)
            .edgesIgnoringSafeArea(.all)
            .simultaneousGesture(
                SpatialTapGesture()
                    .onEnded { value in
                        withAnimation(.spring(response: 0.3)) {
                            vm.clearSelection()
                        }
                    }
            )
            
            if let hub = vm.selectedHub {
                HubCard(hub: hub)
                    .transition(.move(edge: .top))
            }
            
            if let hiBike = vm.selectedHiBike {
                HiBikeCard(hiBike: hiBike)
                    .transition(.move(edge: .top))
            }
            
            if showZoomWarning {
                // 줌아웃 경고 오버레이
                VStack {
                    
                    Image("posik")
                        .resizable()
                        .scaledToFit()
                        .frame(width:300, height: 300)
                    
                    HStack {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.yellow)
                        Text("너무 멀리 가지 말라구!")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                }
                .padding(.top, 50)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}
