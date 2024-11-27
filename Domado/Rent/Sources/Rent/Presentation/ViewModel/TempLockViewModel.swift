//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation
import _MapKit_SwiftUI

public class TempLockViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isHiBike: Bool = false
    private let router: Routing
    
    public init(router: Routing){
        self.router = router
    }
    
    public func showUnparkConfirmView(){
        router.present(sheet: .confirmUnParking)
    }
    
    public func showHikeBikeGuide(){
        router.present(sheet: .showHiBikeGuide)
    }

}
