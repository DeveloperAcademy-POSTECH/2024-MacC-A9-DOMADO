//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

import Core
import Foundation

public final class DefaultAuthRepository: AuthRepository {
    private let networkManager: CoreNetworkManager
    private let logger: Logger
    
    public init(
        networkManager: CoreNetworkManager,
        logger: CoreLogger = .shared
    ) {
        self.networkManager = networkManager
        self.logger = logger
    }
    
    public func signUp(email: String, password: String, name: String, phone: String) async throws {
        do {
            let endpoint = AuthEndpoint.signUp(
                email: email,
                password: password,
                name: name,
                phone: phone
            )
            
            let _: BaseResponse<Nothing> = try await networkManager.request(endpoint)
        } catch let error as NetworkError {
            throw handleNetworkError(error)
        }
    }
    
    public func signIn(email: String, password: String) async throws -> User {
        do {
            let endpoint = AuthEndpoint.signIn(email: email, password: password)
            
            struct LoginResponse: Codable {
                let token: AuthToken
                let user: User
            }
            
            let response: BaseResponse<LoginResponse> = try await networkManager.request(endpoint)
            
            guard let loginData = response.data else {
                throw AuthError.invalidResponse
            }
            
            networkManager.setAuthTokens(loginData.token)
            return loginData.user
        } catch let error as NetworkError {
            throw handleNetworkError(error)
        }
    }
    
    public func signOut() async throws {
        
        do {
            if !networkManager.hasValidTokens() {
                networkManager.clearAuthTokens()
                return
            }
            
            let endpoint = AuthEndpoint.signOut()
            let _: BaseResponse<Nothing> = try await networkManager.authenticatedRequest(endpoint)
            networkManager.clearAuthTokens()
        } catch {
          
            networkManager.clearAuthTokens()
            throw handleNetworkError(error as? NetworkError ?? .unknown(underlyingError: error))
        }
    }
    
    public func getCurrentUser() async throws -> User {
        do {
            let endpoint = AuthEndpoint.getCurrentUser()
            let response: BaseResponse<User> = try await networkManager.authenticatedRequest(endpoint)
            
            guard let user = response.data else {
                throw AuthError.invalidResponse
            }
            
            return user
        } catch let error as NetworkError {
            throw handleNetworkError(error)
        }
    }
    
    public func isAuthenticated() -> Bool {
        networkManager.hasValidTokens()
    }
    
    // MARK: - Private Methods
    
    private func handleNetworkError(_ error: NetworkError) -> AuthError {
        switch error {
        case .serverError(let statusCode, _):
            switch statusCode {
            case 401: return .invalidCredentials
            case 403: return .invalidToken
            case 409: return .emailAlreadyInUse
            default: return .networkError(error)
            }
        case .timeout:
            return .networkError(error)
        case .invalidResponse, .decodingError:
            return .invalidResponse
        default:
            return .unknown
        }
    }
}
