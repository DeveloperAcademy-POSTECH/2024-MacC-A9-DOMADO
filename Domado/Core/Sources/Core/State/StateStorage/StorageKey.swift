//
//  StorageKey.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation

/// 사용자 상태 유지를 위해 각 저장소별로 관리해야하는 데이터 목록을 정의합니다.
public enum StorageKey: String, Sendable {
    
    /// Local Storage Keys : 파일 시스템 기반
    /// 1. 크기가 큰 데이터
    /// 2. 임시 캐시 데이터
    case activeRide = "active_ride"
    
    /// User Defaults Keys : 설정 데이터
    /// 1. 사용자 설정
    /// 2. 앱 상태
    /// 3. 작은 크기 데이터
    case hasSeenOnboarding = "has_seen_onboarding"
    case preferredLanguage = "preferred_language"
    case selectedPaymentMethod = "selected_payment_method"
    case pushNotificationEnabled = "push_notification_enabled"
    
    /// Key Chains: 보안 데이터
    /// 1. 인증 토큰
    /// 2. 사용자 정보
    /// 3. 민감한 데이터
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case userData = "user_data"
    case deviceToken = "device_token"
    
}
