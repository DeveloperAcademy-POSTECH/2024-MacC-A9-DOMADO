//
//  SwiftUIView.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    /// 지도의 초기 카메라 위치 설정
//    @State private var camera = MapCameraPosition.region(MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 36.015, longitude: 129.321),
//        span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
//    ))
    @State private var camera: MapCameraPosition = .automatic
    
    @State private var selectedHub: Hub?
    
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
    
    var body: some View {
        Map(position: $camera) {
            // ForEach로 허브마다 Annotation 생성
            ForEach(hubs) { hub in
                if let coordinate = hub.coordinate {
                    Annotation(
                        hub.hubName,
                        coordinate: CLLocationCoordinate2D(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude
                        ),
                        anchor: .bottom
                    ) {
                        VStack(spacing: 0) {
                            ZStack {
                                Image("hubpin", bundle: .module)

                                // MarkerType에 따른 표시
                                if case let .hub(availableBikes) = hub.markerType {
                                    Text("\(availableBikes)")
                                        .customFont(.button_md_semibold)
                                        .foregroundColor(Color.grayScaleDarker)
                                        .offset(y: -6)
                                }
                            }
                        }
                    }
                    .annotationTitles(.hidden)
                }
            }
        }
        .mapStyle(.standard)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LocationView()
}
