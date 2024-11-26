//
//  AppDelegateAdapter.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Core
import UIKit

final class AppDelegateAdapter: NSObject, UIApplicationDelegate {
   private var pushNotificationManager: PushNotificationManager?
   
   func application(
       _ application: UIApplication,
       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
   ) -> Bool {
       setupAppearance()
       
       // 앱 시작시 상태 복원
       Task {
           // 상태 복원 로직
       }
       
       return true
   }
   
   func application(
       _ application: UIApplication,
       didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
   ) {
       pushNotificationManager?.registerDeviceToken(deviceToken)
   }
   
   func application(
       _ application: UIApplication,
       didFailToRegisterForRemoteNotificationsWithError error: Error
   ) {
       pushNotificationManager?.logger.error("Failed to register for remote notifications: \(error)", category: .notification)
   }
   
   func setPushNotificationManager(_ manager: PushNotificationManager) {
       self.pushNotificationManager = manager
   }
   
   private func setupAppearance() {
       // 앱 외관 설정
   }
}
