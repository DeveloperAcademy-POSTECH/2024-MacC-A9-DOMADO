//
//  WebSocketManager.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

import Foundation

public class WebSocketManager: @unchecked Sendable {
    //MARK: - Properties
    private var webSocketTask: URLSessionWebSocketTask?
    private let session: URLSession
    private let logger: CoreLogger
    private let storage: StateStorage
    
    private var messageContinuation: AsyncStream<WebSocketMessage<AnyDecodable>>.Continuation?
    private var isConnected: Bool = false
    
    // MARK: - Intialization
    init(session: URLSession = .shared,
         logger: CoreLogger = .shared,
         storage: StateStorage
    ) {
        self.session = session
        self.logger = logger
        self.storage = storage
    }
    
    
    // MARK: - Public Methods
    func connect() async throws {
        guard !isConnected else { return }
        
        guard let token: String = try? storage.value(for: .accessToken) else {
            throw NetworkError.serverError(statusCode: 401, message: "Access token not found")
        }
        
        try setupWebSocketTask(with: token)
        webSocketTask?.resume()
        isConnected = true
        receiveMessage()
        
        logger.debug("WebSocket connected", category: .websocket)
    }
    
    func disconnect() {
        guard isConnected else { return }
        
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        messageContinuation?.finish()
        messageContinuation = nil
        isConnected = false
        
        logger.debug("WebSocket disconnected", category: .websocket)
    }
    
    func observeMessages() -> AsyncStream<WebSocketMessage<AnyDecodable>> {
        AsyncStream { continuation in
            self.messageContinuation = continuation
            
            continuation.onTermination = { [weak self] _ in
                self?.disconnect()
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupWebSocketTask(with token: String) throws {
        guard var urlComponents = URLComponents(string: Environment.Values.baseURL) else {
            throw NetworkError.invalidURL
        }
        urlComponents.path = "/ws/notifications"
        urlComponents.scheme = urlComponents.scheme == "https" ? "wss" : "ws"
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        webSocketTask = session.webSocketTask(with: request)
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let message):
                self.handleMessage(message)
                self.receiveMessage()  // 다음 메시지 수신
                
            case .failure(let error):
                self.logger.error("WebSocket receive error: \(error)", category: .websocket)
                self.handleError(error)
            }
        }
    }
    
    private func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let text):
            do {
                let data = text.data(using: .utf8)!
                let decoded = try JSONDecoder().decode(WebSocketMessage<AnyDecodable>.self, from: data)
                messageContinuation?.yield(decoded)
                logger.debug("Received WebSocket message: \(decoded.type)", category: .websocket)
            } catch {
                logger.error("Failed to decode WebSocket message: \(error)", category: .websocket)
            }
            
        case .data(let data):
            do {
                let decoded = try JSONDecoder().decode(WebSocketMessage<AnyDecodable>.self, from: data)
                messageContinuation?.yield(decoded)
                logger.debug("Received WebSocket message: \(decoded.type)", category: .websocket)
            } catch {
                logger.error("Failed to decode WebSocket message: \(error)", category: .websocket)
            }
            
        @unknown default:
            break
        }
    }
    
    private func handleError(_ error: Error) {
        isConnected = false
        
        if let urlError = error as? URLError, urlError.code == .cancelled {
            Task {
                try? await reconnectWithTokenRefresh()
            }
        } else {
            // 일반적인 에러의 경우 일정 시간 후 재연결 시도
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000)  // 3초 대기
                try? await reconnect()
            }
        }
    }
    
    private func reconnectWithTokenRefresh() async throws {
        guard let refreshToken: String = try? storage.value(for: .refreshToken) else {
            throw NetworkError.serverError(statusCode: 401, message: "Refresh token not found")
        }
        
        let networkManager = CoreNetworkManager(storage: storage)
        let refreshEndpoint = Endpoint(
            path: "/auth/refresh",
            method: .POST,
            body: try? JSONSerialization.data(withJSONObject: ["refreshToken": refreshToken])
        )
        
        do {
            let response: BaseResponse<AuthToken> = try await networkManager.request(refreshEndpoint)
            if let newToken = response.data {
                try storage.setValue(newToken, for: .accessToken)
                try await reconnect()
            }
        } catch {
            disconnect()
            throw NetworkError.serverError(statusCode: 401, message: "Token refresh failed")
        }
    }
    
    private func reconnect() async throws {
        disconnect()
        try await connect()
    }
}
