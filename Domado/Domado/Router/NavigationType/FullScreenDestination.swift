//
//  FullScreenDestination.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Foundation

/// FullScreen 형태로 보여줄 화면 목록입니다. 
enum FullScreenDestination: Identifiable, Hashable{
    case login
    case onboarding
    
    var id: String {
        switch self {
        case .login: return "login"
        case .onboarding: return "onboarding"
        }
    }
}
