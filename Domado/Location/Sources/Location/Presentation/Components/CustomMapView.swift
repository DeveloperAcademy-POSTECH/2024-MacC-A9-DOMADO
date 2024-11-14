//
//  CustomMapView.swift
//  Location
//
//  Created by yoomin on 11/15/24.
//
import SwiftUI
import MapKit

struct CustomMapView: View {
    @Binding var selectedMarker: Location?
    let hubMarkers: [Location]
    let hiBikeMarkers: [Location]
    
    var body: some View {
        Map {
            ForEach(hubMarkers + hiBikeMarkers) { marker in
                Annotation(marker.name, coordinate: marker.coordinate) {
                    Button(action: {
                        selectedMarker = marker
                    }) {
                        Marker(marker: marker)
                    }
                }
            }
        }
        .onTapGesture {
            selectedMarker = nil
        }
    }
}

#Preview {
    CustomMapView(
        selectedMarker: .constant(nil),
        hubMarkers: [
            Location(name: "Hub A", coordinate: CLLocationCoordinate2D(latitude: 36.0179, longitude: 129.3242), type: .hub)
        ],
        hiBikeMarkers: [
            Location(name: "HiBike 1", coordinate: CLLocationCoordinate2D(latitude: 36.0181, longitude: 129.3244), type: .hiBike)
        ]
    )
}
