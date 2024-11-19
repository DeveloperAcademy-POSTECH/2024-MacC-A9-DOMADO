//
//  AppState.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Core 
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
    
    private let storage: StateStorage
    
    // MARK: - Initialization
    init(storage: StateStorage) {
        self.storage = storage
        
        // 저장된 상태 복원
        restoreState()
        
    }
    
    // MARK: - State Restoration
     private func restoreState() {
         do {
             // 인증 상태 복원
             if storage.hasValue(for: .authToken) {
                 let token: String = try storage.value(for: .authToken)
                 authState = .authenticated
             } else {
                 authState = .unauthenticated
             }
             
             // 온보딩 상태 복원
             if storage.hasValue(for: .hasSeenOnboarding) {
                 hasSeenOnboarding = try storage.value(for: .hasSeenOnboarding)
             }
             
             // 주행 상태 복원
             if storage.hasValue(for: .activeRide) {
                 rideState = .active
             }
         } catch {
             // 상태 복원 실패 시 기본값 사용
             authState = .unknown
             rideState = .none
             hasSeenOnboarding = false
         }
     }
     
     // MARK: - State Persistence
     private func persistState() {
         do {
             // 온보딩 상태 저장
             try storage.setValue(hasSeenOnboarding, for: .hasSeenOnboarding)
             
             // 인증 관련 데이터는 이미 storage에서 관리되고 있음
             // 주행 상태도 이미 storage에서 관리되고 있음
         } catch {
             // 상태 저장 실패 로깅
             print("Failed to persist app state: \(error)")
         }
     }
     
     // MARK: - Public Methods
     
     /// 사용자 인증 상태를 업데이트합니다
     func updateAuthState(_ newState: AuthState) {
         authState = newState
         
         // 로그아웃 시 관련 데이터 삭제
         if newState == .unauthenticated {
             do {
                 try storage.removeValue(for: .authToken)
                 try storage.removeValue(for: .refreshToken)
                 try storage.removeValue(for: .userData)
             } catch {
                 print("Failed to clear auth data: \(error)")
             }
         }
     }
     
     /// 주행 상태를 업데이트합니다
     func updateRideState(_ newState: RideState) {
         rideState = newState
         
         // 주행 종료 시 관련 데이터 삭제
         if newState == .completed || newState == .none {
             do {
                 try storage.removeValue(for: .activeRide)
             } catch {
                 print("Failed to clear ride data: \(error)")
             }
         }
     }
     
     /// 온보딩 완료 상태를 업데이트합니다
     func setOnboardingComplete() {
         hasSeenOnboarding = true
         do {
             try storage.setValue(hasSeenOnboarding, for: .hasSeenOnboarding)
         } catch {
             print("Failed to save onboarding state: \(error)")
         }
     }
     
     /// 모든 상태와 저장된 데이터를 초기화합니다
     func reset() {
         do {
             try storage.clearAll()
             authState = .unauthenticated
             rideState = .none
             hasSeenOnboarding = false
         } catch {
             print("Failed to reset app state: \(error)")
         }
     }
}
