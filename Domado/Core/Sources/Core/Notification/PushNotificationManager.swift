//
//  PushNotificationManager.swift
//  Core
//
//  Created by 이종선 on 11/24/24.
//


import Foundation
import UserNotifications
import UIKit

public final class PushNotificationManager: NSObject, @unchecked Sendable {
    private let storage: StateStorage
    private let networkManager: CoreNetworkManager
    public let logger: CoreLogger
    
    public init(
        storage: StateStorage,
        logger: CoreLogger,
        networkManager: CoreNetworkManager
    ) {
        self.storage = storage
        self.logger = logger
        self.networkManager = networkManager
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// 푸시 알림 권한을 요청합니다.
    public func requestAuthorization() async {
        do {
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: options)
            
            if granted {
                await UIApplication.shared.registerForRemoteNotifications()
            }
            
            logger.debug("Push notification permission \(granted ? "granted" : "denied")", category: .notification)
        } catch {
            logger.error("Push notification permission request failed: \(error)", category: .notification)
        }
    }
    
    /// 로그인 성공 시 호출되어야 하는 메서드입니다.
    /// 저장된 디바이스 토큰이 있다면 서버에 등록을 시도합니다.
    public func onLoginSuccess() {
        Task { 
            await registerStoredDeviceToken()
        }
    }
    
    /// 저장된 디바이스 토큰을 서버에 등록합니다.
    private func registerStoredDeviceToken() async {
        
        
        do {
            if let token: String = try? storage.value(for: .deviceToken) {
                registerTokenWithServer(token)
            }
        }
    }
    
    /// APNS로부터 받은 디바이스 토큰을 처리합니다.
    /// - Parameter deviceToken: APNS로부터 받은 디바이스 토큰 데이터
    public func registerDeviceToken(_ deviceToken: Data) {
        
        
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        logger.debug("Received device token: \(tokenString)", category: .notification)
        
        // 디바이스 토큰을 Keychain에 저장
        do {
            try storage.setValue(tokenString, for: .deviceToken)
            
            // 액세스 토큰이 있는 경우에만 서버에 등록
            if storage.hasValue(for: .accessToken) {
                registerTokenWithServer(tokenString)
            }
        } catch {
            logger.error("Failed to save device token: \(error)", category: .notification)
            
            // Keychain 저장 실패 시 구체적인 에러 로깅
            if let keychainError = error as? KeychainDomainError {
                logger.error("Keychain error: \(keychainError.errorDescription)", category: .notification)
            }
        }
    }
    
    /// 디바이스 토큰을 서버에 등록합니다.
    /// - Parameter token: 등록할 디바이스 토큰 문자열
    private func registerTokenWithServer(_ token: String) {
        
        Task { [networkManager, logger] in
            do {
                let endpoint = Endpoint(
                    path: "/api/v1/notifications/token",
                    method: .POST,
                    body: try? JSONEncoder().encode(DeviceTokenRequest(token: token))
                )
                
                let _: BaseResponse<Nothing> = try await networkManager.authenticatedRequest(endpoint)
                logger.debug("Device token registered with server", category: .notification)
            } catch {
                logger.error("Failed to register device token: \(error)", category: .notification)
            }
        }
    }
    
    /// 로그아웃 시 호출되어야 하는 메서드입니다.
    /// 디바이스 토큰을 삭제합니다.
    public func onLogout() {
        
        do {
            try storage.removeValue(for: .deviceToken)
            logger.debug("Device token removed on logout", category: .notification)
        } catch {
            logger.error("Failed to remove device token: \(error)", category: .notification)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension PushNotificationManager: UNUserNotificationCenterDelegate {
   public func userNotificationCenter(
       _ center: UNUserNotificationCenter,
       willPresent notification: UNNotification,
       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
   ) {
       completionHandler([.banner, .sound, .badge])
   }
   
   public func userNotificationCenter(
       _ center: UNUserNotificationCenter,
       didReceive response: UNNotificationResponse,
       withCompletionHandler completionHandler: @escaping () -> Void
   ) {
       
       let userInfo = response.notification.request.content.userInfo
       logger.debug("Received notification: \(userInfo)", category: .notification)
       completionHandler()
   }
}
