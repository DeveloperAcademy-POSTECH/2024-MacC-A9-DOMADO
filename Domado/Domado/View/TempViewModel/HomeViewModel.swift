//
//  HomeViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Core
import Foundation
import _MapKit_SwiftUI

class HomeViewModel: ObservableObject {
    
    private let router: AppRouter
    private let appState: AppState
    private let webSocketManager: WebSocketManager
    private let pushNotificationManager: PushNotificationManager
    
    @Published var isWebSocketConnected: Bool = false
    @Published var lastMessage: String?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var showMyAccountCard = false 
       
    private var messageTask: Task<Void, Never>?
    
    init(router: AppRouter, appState: AppState, webSocketManager: WebSocketManager, pushNotificationManager: PushNotificationManager ) {
        self.router = router
        self.appState = appState
        self.webSocketManager = webSocketManager
        self.pushNotificationManager = pushNotificationManager
        
        setupWebSocket()
        setupPushNotification()
    }
    
    private func setupPushNotification() {
        pushNotificationManager.onLoginSuccess()
    }
    
    func rentBikeWithQR() {
//        guard checkAuthStatus() else { return }
        router.present(fullScreen: .qrScanner)
    }
    
//    private func checkAuthStatus() -> Bool {
//        switch appState.authState {
//        case .authenticated:
//            return true
//        case .unknown, .unauthenticated:
//            router.present(fullScreen: .login)
//            return false
//        }
//    }
    
    func showInfoCard() {
        router.present(fullScreen: .myInfo)
    }
    
    private func setupWebSocket() {
        // WebSocket 연결 시작
        Task {
            do {
                try await webSocketManager.connect()
                await MainActor.run {
                    self.isWebSocketConnected = true
                }
                
                // 메시지 스트림 관찰 시작
                let messageStream = webSocketManager.observeMessages()
                
                messageTask = Task {
                    for await message in messageStream {
                        await handleWebSocketMessage(message)
                    }
                }
            } catch {
                await MainActor.run {
                    self.isWebSocketConnected = false
                    self.showAlert = true
                    self.alertMessage = "WebSocket 연결 실패: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func handleWebSocketMessage(_ message: WebSocketMessage<AnyDecodable>) async {
        
        // 메시지에서 필요한 값 미리 복사
        let messageType = message.type
        let messagePayload = message.payload?.value
        
        await MainActor.run {
            // 메시지 타입에 따른 처리
            switch messageType {
            case "NOTIFICATION":
                self.lastMessage = "새로운 알림: \(messagePayload ?? "")"
                self.showAlert = true
                self.alertMessage = self.lastMessage ?? ""
                
            case "MOVE":
                self.rentBikeWithQR()
            
                
            default:
                self.lastMessage = "알 수 없는 메시지: \(messageType)"
            }
        }
    }
    
    
    deinit {
        messageTask?.cancel()
        webSocketManager.disconnect()
    }
}
