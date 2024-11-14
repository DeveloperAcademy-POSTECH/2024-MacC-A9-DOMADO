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
    
    let hubMarkers = [
        Location(name: "Hub A", coordinate: CLLocationCoordinate2D(latitude: 36.0179, longitude: 129.3242), type: .hub),
        Location(name: "Hub B", coordinate: CLLocationCoordinate2D(latitude: 36.0180, longitude: 129.3243), type: .hub)
    ]
    
    let hiBikeMarkers = [
        Location(name: "HiBike 1", coordinate: CLLocationCoordinate2D(latitude: 36.0181, longitude: 129.3244), type: .hiBike),
        Location(name: "HiBike 2", coordinate: CLLocationCoordinate2D(latitude: 36.0182, longitude: 129.3245), type: .hiBike)
    ]
    
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
    CustomMapView(selectedMarker: .constant(nil))
}
