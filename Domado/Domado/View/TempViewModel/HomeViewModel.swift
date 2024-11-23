//
//  HomeViewModel.swift
//  Domado
//
//  Created by 이종선 on 11/22/24.
//

import Core
import Foundation

class HomeViewModel: ObservableObject {
    
    private let router: AppRouter
    private let appState: AppState
    private let webSocketManager: WebSocketManager
    
    @Published var isWebSocketConnected: Bool = false
    @Published var lastMessage: String?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
       
    private var messageTask: Task<Void, Never>?
    
    init(router: AppRouter, appState: AppState, webSocketManager: WebSocketManager) {
        self.router = router
        self.appState = appState
        self.webSocketManager = webSocketManager
        
        setupWebSocket()
    }
    
    func rentBikeWithQR() {
        router.present(fullScreen: .qrScanner)
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
        await MainActor.run {
            // 메시지 타입에 따른 처리
            switch message.type {
            case "NOTIFICATION":
                self.lastMessage = "새로운 알림: \(message.payload?.value ?? "")"
                self.showAlert = true
                self.alertMessage = self.lastMessage ?? ""
                
            case "MOVE":
                self.rentBikeWithQR()
            
                
            default:
                self.lastMessage = "알 수 없는 메시지: \(message.type)"
            }
        }
    }
    
    
    deinit {
        messageTask?.cancel()
        webSocketManager.disconnect()
    }
}
