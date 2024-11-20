//
//  AppDelegateAdapter.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import UIKit

final class AppDelegateAdapter: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setupPushNotifications(application)
        setupAppearance()
        
        // 앱 시작시 상태 복원
        Task {
         
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // 앱이 백그라운드로 전환될 때
        Task {
          
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 앱이 활성화될 때
        Task {
          
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // 앱이 종료될 때
        Task {
          
        }
    }
    
    private func setupPushNotifications(_ application: UIApplication) {
        // 푸시 알림 설정
    }
    
    private func setupAppearance() {
        // 앱 외관 설정
    }
}

