//
//  SwiftUIView.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    
    /// 지도의 초기 카메라 위치 설정
    @State private var camera = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.015, longitude: 129.321),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    ))
    
    @State private var selectedHub: Hub?
    @State private var selectedBike: Bike?
    
    /// 지도에 표시될 허브 목록
    let hubs: [Hub] = [
        Hub(id: "101", hubName: "무은재기념관", coordinate: (36.011883, 129.322422), availableBikes: 6, stations: []),
        Hub(id: "102", hubName: "학생회관", coordinate: (36.012892, 129.321041), availableBikes: 3, stations: []),
        Hub(id: "103", hubName: "환경공학동", coordinate: (36.012126, 129.319904), availableBikes: 4, stations: []),
        Hub(id: "201", hubName: "생활관21동", coordinate: (36.016960, 129.320701), availableBikes: 6, stations: []),
        Hub(id: "202", hubName: "생활관3동", coordinate: (36.016084, 129.320266), availableBikes: 3, stations: []),
        Hub(id: "203", hubName: "생활관12동", coordinate: (36.016484, 129.321750), availableBikes: 3, stations: []),
        Hub(id: "204", hubName: "생활관15동", coordinate: (36.017173, 129.322506), availableBikes: 3, stations: []),
        Hub(id: "301", hubName: "박태준학술정보관", coordinate: (36.012516, 129.326191), availableBikes: 6, stations: []),
        Hub(id: "302", hubName: "친환경소재대학원", coordinate: (36.010472, 129.327792), availableBikes: 2, stations: []),
        Hub(id: "401", hubName: "제1실험동", coordinate: (36.020618, 129.321501), availableBikes: 3, stations: []),
        Hub(id: "402", hubName: "기계실험동", coordinate: (36.021358, 129.321144), availableBikes: 3, stations: []),
        Hub(id: "403", hubName: "가속기IBS", coordinate: (36.023726, 129.312361), availableBikes: 3, stations: [])
    ]
    
    // HiBike Data
    let hiBikes: [Bike] = [
        // 교사 지역 (5대)
        Bike(coordinate: (36.012300, 129.321500), id: "BIKE046", bikeName: "BIKE046", isHiBike: true, batteryLevel: 87, homeHubName: "무은재기념관"),
        //        Bike(coordinate: (36.012100, 129.321200), id: "BIKE047", bikeName: "BIKE047", isHiBike: true, batteryLevel: 84, homeHubName: "학생회관"),
        //        Bike(coordinate: (36.012000, 129.320800), id: "BIKE048", bikeName: "BIKE048", isHiBike: true, batteryLevel: 76, homeHubName: "환경공학동"),
        //        Bike(coordinate: (36.011900, 129.321700), id: "BIKE049", bikeName: "BIKE049", isHiBike: true, batteryLevel: 81, homeHubName: "무은재기념관"),
        //        Bike(coordinate: (36.012400, 129.321100), id: "BIKE050", bikeName: "BIKE050", isHiBike: true, batteryLevel: 89, homeHubName: "학생회관"),
        
        // 생활관 지역 (5대)
        Bike(coordinate: (36.016500, 129.321000), id: "BIKE051", bikeName: "BIKE051", isHiBike: true, batteryLevel: 86, homeHubName: "생활관21동"),
        //        Bike(coordinate: (36.016300, 129.321200), id: "BIKE052", bikeName: "BIKE052", isHiBike: true, batteryLevel: 83, homeHubName: "생활관3동"),
        //        Bike(coordinate: (36.016700, 129.321500), id: "BIKE053", bikeName: "BIKE053", isHiBike: true, batteryLevel: 85, homeHubName: "생활관12동"),
        //        Bike(coordinate: (36.016900, 129.321800), id: "BIKE054", bikeName: "BIKE054", isHiBike: true, batteryLevel: 80, homeHubName: "생활관15동"),
        //        Bike(coordinate: (36.016200, 129.320900), id: "BIKE055", bikeName: "BIKE055", isHiBike: true, batteryLevel: 75, homeHubName: "생활관21동"),
        
        // 인화지역 (5대)
        Bike(coordinate: (36.011800, 129.326500), id: "BIKE056", bikeName: "BIKE056", isHiBike: true, batteryLevel: 82, homeHubName: "박태준학술정보관"),
        //                Bike(coordinate: (36.011500, 129.326800), id: "BIKE057", bikeName: "BIKE057", isHiBike: true, batteryLevel: 88, homeHubName: "박태준학술정보관"),
        //        Bike(coordinate: (36.011200, 129.327000), id: "BIKE058", bikeName: "BIKE058", isHiBike: true, batteryLevel: 79, homeHubName: "친환경소재대학원"),
        //        Bike(coordinate: (36.011600, 129.326700), id: "BIKE059", bikeName: "BIKE059", isHiBike: true, batteryLevel: 92, homeHubName: "박태준학술정보관"),
        //        Bike(coordinate: (36.011000, 129.327200), id: "BIKE060", bikeName: "BIKE060", isHiBike: true, batteryLevel: 87, homeHubName: "친환경소재대학원")
    ]
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $camera) {
                // 사용자 위치 표시
                if let userLocation = locationManager.userLocation {
                    Annotation("현재 위치", coordinate: userLocation) {
                        ZStack {
                            Circle()
                                .fill(Color.MylocationMarker)
                                .frame(width: 19, height: 19)
                            Circle()
                                .fill(Color.grayScaleWhite)
                                .frame(width: 27, height: 27)
                                .shadow(color: Color.MylocationMarker, radius: 15.7, x: 0, y: 0)
                        }
                    }
                }
                
                
                // Hubs 표시
                ForEach(hubs) { hub in
                    if let coordinate = hub.coordinate {
                        Annotation(
                            hub.hubName,
                            coordinate: CLLocationCoordinate2D(
                                latitude: coordinate.0,
                                longitude: coordinate.1
                            ),
                            anchor: .bottom
                        ) {
                            Button {
                                selectedHub = hub
                                selectedBike = nil
                                
                                // Update camera to focus on selected bike
                                camera = .region(MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(
                                        latitude: coordinate.0,
                                        longitude: coordinate.1
                                    ),
                                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                                ))
                            } label: {
                                ZStack {
                                    Image("hubpin", bundle: .module)
                                    
                                    Text("\(hub.availableBikes)")
                                        .customFont(.button_md_semibold)
                                        .foregroundColor(Color.grayScaleDarker)
                                        .offset(y: -6)
                                }
                            }
                            .scaleEffect(selectedHub?.id == hub.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: selectedHub?.id)
                        }
                    }
                }
                
                // HiBikes 표시
                ForEach(hiBikes) { bike in
                    if let coordinate = bike.coordinate {
                        Annotation(
                            bike.bikeName,
                            coordinate: CLLocationCoordinate2D(
                                latitude: coordinate.0,
                                longitude: coordinate.1
                            ),
                            anchor: .bottom
                        ) {
                            Button {
                                selectedBike = bike
                                selectedHub = nil
                                
                                // Update camera to focus on selected bike
                                camera = .region(MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(
                                        latitude: coordinate.0,
                                        longitude: coordinate.1
                                    ),
                                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                                ))
                            } label: {
                                ZStack {
                                    Image("hiBikepin", bundle: .module)
                                    
                                    Text(bike.homeHubName.hasPrefix("생활관")
                                         ? "생\(bike.homeHubName.filter { $0.isNumber })"
                                         : "\(bike.homeHubName.prefix(2))")
                                    .customFont(.button_md_semibold)
                                    .foregroundColor(Color.grayScaleDarker)
                                    .offset(x: 6)
                                }
                            }
                            .scaleEffect(selectedBike?.id == bike.id ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: selectedBike?.id)
                        }
                    }
                }
            }
            .mapStyle(.standard)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                // 지도를 탭하면 선택 해제
                selectedHub = nil
                selectedBike = nil
            }
            // 사용자 위치가 업데이트될 때마다 카메라 위치 업데이트
            // locationManager가 publish하는 값이 바뀔 때마다 실행
            .onReceive(locationManager.$userLocation) { newLocation in
                if let location = newLocation {
                    camera = .region(MKCoordinateRegion(
                        center: location,
                        span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
                    ))
                }
            }
            
            
            // 선택된 항목에 따라 카드 표시
            if let hub = selectedHub {
                HubCard(hub: hub)
                //                    .padding(.top, 0)
                    .transition(.move(edge: .top))
            }
            
            if let bike = selectedBike {
                HiBikeCard(
                    bikeName: bike.bikeName,
                    homeHubName: bike.homeHubName
                )
                //                .padding(.top, 0)
                .transition(.move(edge: .top))
            }
            
        }
        
    }
    
}


#Preview {
    LocationView()
}
