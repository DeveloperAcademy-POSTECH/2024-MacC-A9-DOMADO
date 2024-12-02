//
//  File.swift
//  Core
//
//  Created by 이종선 on 11/20/24.
//

import Foundation


public final class AppState: ObservableObject {
    
    // MARK: State Enum
    /// 인증상태
    public enum AuthState: Equatable {
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
    public enum RideState: Equatable {
        // TODO: 연관값으로 Ride을 받아 주행상태에 따라
        case none
        case active
        case paused
        case completed
    }
    
    @Published private(set) public var authState: AuthState = .unauthenticated
    @Published private(set) public var rideState: RideState = .none
    private(set) public var hasSeenOnboarding: Bool = false
    private(set) public var currentUser: AppUser? = nil
    private(set) public var currentScanningBike: BikeQRData? = nil
    
    
    //MARK: 화면 제어를 위한 프로퍼티들
    private(set) public var isProcessingScanning = false
    @Published private(set) public var isProcessingPayment = false
    
    private let storage: StateStorage
    
    // MARK: - Initialization
    public init(storage: StateStorage) {
        self.storage = storage
        
        restoreState()
        
    }
    
    // MARK: - State Restoration
    private func restoreState() {
        do {
            // 1. 인증 상태 복원
            if storage.hasValue(for: .accessToken) {
                // 토큰이 있을 때만 사용자 정보 복원 시도
                if let user: AppUser = try? storage.value(for: .userData) {
                    currentUser = user
                    authState = .authenticated
                    
                    if user.currentRentalId != nil {
                        // TODO: 주행상태 복구 로직 필요
                        rideState = .active
                    }
                }
            } else {
                // 토큰이 없으면 저장된 사용자 정보 삭제
                try? storage.removeValue(for: .userData)
                currentUser = nil
                authState = .unauthenticated
                rideState = .none
            }
            
            // 온보딩 상태 복원
            if storage.hasValue(for: .hasSeenOnboarding) {
                hasSeenOnboarding = try storage.value(for: .hasSeenOnboarding)
            }
            
        } catch {
            // 상태 복원 실패 시 기본값 사용
            authState = .unknown
            rideState = .none
            hasSeenOnboarding = false
            currentUser = nil
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
    public func updateUserState(to user: AppUser) {
        currentUser = user
        updateAuthState(.authenticated)
        
        // 사용자 정보 저장
        do {
            try storage.setValue(user, for: .userData)
        } catch {
            print("Failed to save user data: \(error)")
        }
    }
    
    func updateAuthState(_ newState: AuthState) {
        authState = newState
        
        // 로그아웃 시 관련 데이터 모두 삭제
        if newState == .unauthenticated {
            do {
                try storage.removeValue(for: .accessToken)
                try storage.removeValue(for: .refreshToken)
                try storage.removeValue(for: .userData)
                currentUser = nil
                rideState = .none
            } catch {
                print("Failed to clear auth data: \(error)")
            }
        }
    }
    
    /// 주행 상태를 업데이트합니다
    public func updateRideState(_ newState: RideState) {
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
            currentUser = nil 
        } catch {
            print("Failed to reset app state: \(error)")
        }
    }
    
    // MARK: - QR코드 Scanning 상태 관리
    public func startScanning(){
        self.isProcessingScanning = true
    }
    
    public func doneScanning(){
        self.isProcessingScanning = false
    }
    
    // MARK: - 자전거 대여 상태 관리
    public func setCurrentScanningBike(_ bikeData: BikeQRData) {
        self.currentScanningBike = bikeData
    }
    
    public func clearCurrentScanningBike() {
        self.currentScanningBike = nil
    }
    
    // MARK: - 결제 진행 상태 관리
    public func startPaymentProcessing(){
        self.isProcessingPayment = true
    }
    
    public func donePaymentProcessing(){
        self.isProcessingPayment = false
    }
}
