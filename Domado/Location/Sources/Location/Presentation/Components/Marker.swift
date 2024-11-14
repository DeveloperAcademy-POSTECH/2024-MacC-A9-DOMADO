//
//  MarkerView.swift
//  Location
//
//  Created by yoomin on 11/15/24.
//

import SwiftUI
import MapKit

struct Marker: View {
    let marker: Location
    
    var body: some View {
        VStack {
            Image(systemName: marker.type == .hub ? "mappin.circle.fill" : "bicycle.circle.fill")
                .foregroundColor(marker.type == .hub ? .blue : .green)
            Text(marker.name)
                .font(.caption)
        }
    }
}

#Preview {
    Marker(marker: Location(name: "Test Hub", coordinate: CLLocationCoordinate2D(latitude: 36.0179, longitude: 129.3242), type: .hub))
}
