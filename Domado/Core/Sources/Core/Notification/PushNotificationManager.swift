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
   
   public func registerDeviceToken(_ deviceToken: Data) {
       let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
       logger.debug("Received device token: \(tokenString)", category: .notification)
       
       if storage.hasValue(for: .accessToken) {
           registerTokenWithServer(tokenString)
       }
   }
   
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
