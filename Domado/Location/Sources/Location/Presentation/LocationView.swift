//
//  SwiftUIView.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.0179, longitude: 129.3242),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var selectedMarker: Location?
    
    let hubMarkers = [
        Location(name: "Hub A", coordinate: CLLocationCoordinate2D(latitude: 36.0179, longitude: 129.3242), type: .hub),
        Location(name: "Hub B", coordinate: CLLocationCoordinate2D(latitude: 36.0180, longitude: 129.3243), type: .hub)
    ]
    
    let hiBikeMarkers = [
        Location(name: "HiBike 1", coordinate: CLLocationCoordinate2D(latitude: 36.0181, longitude: 129.3244), type: .hiBike),
        Location(name: "HiBike 2", coordinate: CLLocationCoordinate2D(latitude: 36.0182, longitude: 129.3245), type: .hiBike)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomMapView(selectedMarker: $selectedMarker, hubMarkers: hubMarkers, hiBikeMarkers: hiBikeMarkers)
            
            if let selectedMarker = selectedMarker {
                if selectedMarker.type == .hub {
                    HubCard()
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .padding()
                } else {
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack {
                            ForEach(hiBikeMarkers) { marker in
                                HiBikeCard()
                                    .frame(width: UIScreen.main.bounds.width - 40)
                            }
                        }
                    }
                    .frame(height: 200)
                    .padding()
                }
            }
            
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let type: MarkerType
    
    enum MarkerType {
        case hub
        case hiBike
    }
}


#Preview {
    LocationView()
}
