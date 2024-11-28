//
//  LocationViewModel.swift
//  Location
//
//  Created by yoomin on 11/5/24.
//

import Core
import SwiftUI
import _MapKit_SwiftUI

public class LocationViewModel: ObservableObject {
    
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    public init() {
        
    }
}
