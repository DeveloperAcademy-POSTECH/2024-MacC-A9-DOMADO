//
//  CoreNetworkManager.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

import Foundation

public final class CoreNetworkManager: NetworkManager {
    private let session: URLSession
    private let logger: CoreLogger
    private let storage: StateStorage
    private let timeoutInterval: TimeInterval = 30.0
    
    public init(
        session: URLSession = .shared,
        logger: CoreLogger = .shared,
        storage: StateStorage
        
    ) {
        self.session = session
        self.logger = logger
        self.storage = storage
        
    }
    
    // MARK: - Public Methods
    
    /// 일반 네트워크 요청을 수행합니다.
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try buildRequest(from: endpoint)
        return try await performRequest(request)
    }
    
    /// 인증이 필요한 네트워크 요청을 수행합니다.
    public func authenticatedRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        do {
            return try await performAuthenticatedRequest(endpoint)
        } catch let error as NetworkError {
            if case .serverError(statusCode: 401, _) = error {
                return try await handleTokenRefresh(endpoint: endpoint)
            }
            throw error
        }
    }
    
    // MARK: - Token Management
    
    /// 새로운 인증 토큰을 저장합니다.
    public func setAuthTokens(_ token: AuthToken) {
        do {
            try storage.setValue(token.accessToken, for: .accessToken)
            try storage.setValue(token.refreshToken, for: .refreshToken)
            logger.debug("Successfully stored new auth tokens", category: .network)
        } catch {
            logger.error("Failed to store auth tokens: \(error)", category: .network)
        }
    }
    
    /// 저장된 모든 인증 토큰을 삭제합니다.
    public func clearAuthTokens() {
        do {
            try storage.removeValue(for: .accessToken)
            try storage.removeValue(for: .refreshToken)
            logger.debug("Successfully cleared auth tokens", category: .network)
        } catch {
            logger.error("Failed to clear auth tokens: \(error)", category: .network)
        }
    }
    
    /// 현재 저장된 토큰이 있는지 확인합니다.
    public func hasValidTokens() -> Bool {
        storage.hasValue(for: .accessToken) && storage.hasValue(for: .refreshToken)
    }
    
    // MARK: - Private Methods
    
    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard let url = buildURL(from: endpoint) else {
            logger.error("Failed to build URL from endpoint: \(endpoint.path)", category: .network)
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        // 기본 헤더 설정
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // 엔드포인트의 커스텀 헤더 추가
        if let customHeaders = endpoint.headers {
            headers.merge(customHeaders) { _, new in new }
        }
        
        // 모든 헤더를 요청에 추가
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        logger.debug("Built request for URL: \(url.absoluteString)", category: .network)
        logger.debug("Headers: \(headers)", category: .network)
        
        return request
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        logger.debug("Starting request: \(request.url?.absoluteString ?? "")", category: .network)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid response type received", category: .network)
                throw NetworkError.invalidResponse
            }
            
            logger.debug("Received response with status code: \(httpResponse.statusCode)", category: .network)
            
            try validateResponse(httpResponse, data: data)
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                logger.error("Decoding failed: \(error)", category: .network)
                throw NetworkError.decodingError(underlyingError: error)
            }
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError where error.code == .timedOut {
            logger.error("Request timed out", category: .network)
            throw NetworkError.timeout
        } catch {
            logger.error("Request failed: \(error)", category: .network)
            throw NetworkError.requestFailed(underlyingError: error)
        }
    }
    
    private func performAuthenticatedRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let accessToken: String = try? storage.value(for: .accessToken) else {
            throw NetworkError.serverError(statusCode: 401, message: "Access token not found")
        }
        
        var authenticatedEndpoint = endpoint
        var headers = endpoint.headers ?? [:]
        headers["Authorization"] = "Bearer \(accessToken)"
        authenticatedEndpoint.headers = headers
        
        return try await request(authenticatedEndpoint)
    }
    
    private func handleTokenRefresh<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let refreshToken: String = try? storage.value(for: .refreshToken) else {
            clearAuthTokens()
            throw NetworkError.serverError(statusCode: 401, message: "Refresh token not found")
        }
        
        let refreshEndpoint = Endpoint(
            path: "/auth/refresh",
            method: .POST,
            body: try? JSONSerialization.data(withJSONObject: ["refreshToken": refreshToken])
        )
        
        do {
            let response: BaseResponse<AuthToken> = try await request(refreshEndpoint)
            guard let newToken = response.data else {
                throw NetworkError.serverError(statusCode: 401, message: "Token refresh failed")
            }
            
            setAuthTokens(newToken)
            return try await performAuthenticatedRequest(endpoint)
        } catch {
            clearAuthTokens()
            throw NetworkError.serverError(
                statusCode: 401,
                message: "Token refresh failed: \(error.localizedDescription)"
            )
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse, data: Data) throws {
        let statusCode = response.statusCode
        
        guard (200...299).contains(statusCode) else {
            let message = try? decodeErrorMessage(from: data)
            logger.error("Server error: Status \(statusCode), Message: \(message ?? "None")", category: .network)
            throw NetworkError.serverError(statusCode: statusCode, message: message)
        }
    }
    
    private func decodeErrorMessage(from data: Data) throws -> String? {
        struct ServerError: Decodable {
            let error: String?
        }
        
        return try? JSONDecoder().decode(ServerError.self, from: data).error
    }
    
    private func buildURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: Environment.Values.baseURL)
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
