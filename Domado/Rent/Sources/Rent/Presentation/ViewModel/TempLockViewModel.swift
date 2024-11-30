//
//  File.swift
//  Rent
//
//  Created by 이종선 on 11/27/24.
//

import Core
import Foundation
import _MapKit_SwiftUI

@MainActor
public class TempLockViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isHiBike: Bool = false
    @Published var isPassed: Bool = false 
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

    public func showCompleteHiBike(){
        isPassed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.router.present(sheet: .showHiBikeComplete)
        }
    }

}
