//
//  AppState.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Foundation

final class AppState: ObservableObject {
    
    // MARK: State Enum
    /// 인증상태
    enum AuthState: Equatable {
        /// 초기상태 : 앱이 실행되고 사용자의 인증 상태를 아직 확인하지 않은 초기 상태
        /// 예를 들어 앱 시작시 서버나 로컬 저장소에서 사용자 인증 정보를 가져오는 동안 잠깐 동안 인증 상태를 알 수 없을 때
        /// 오류상태: 인증 여부를 확인하는 과정에서 네트워크 또는 서버 오류가 발생해 인증 여부를 알 수 없는 상태
        case unknown
        /// 인증 상태
        case authenticated
        /// 미인증 상태
        case unauthenticated
    }
    /// 자전거 주행 상태
    enum RideState: Equatable {
        // TODO: 연관값으로 Ride을 받아 주행상태에 따라
        case none
        case active
        case paused
        case completed
    }
    
    @Published private(set) var authState: AuthState = .unknown
    @Published private(set) var rideState: RideState = .none
    @Published private(set) var hasSeenOnboarding: Bool = false
    

}
