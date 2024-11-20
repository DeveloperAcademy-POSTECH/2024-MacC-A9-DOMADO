//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

import Core
import Foundation

enum AuthEndpoint {
    static let basePath = "/api/auth"
    
    static func signUp(email: String, password: String, name: String, phone: String) -> Endpoint {
        let params = ["email": email, "password": password, "name": name, "phone": phone]
        return Endpoint(
            path: basePath + "/register",
            method: .POST,
            body: try? JSONSerialization.data(withJSONObject: params)
        )
    }
    
    static func signIn(email: String, password: String) -> Endpoint {
        let params = ["email": email, "password": password]
        return Endpoint(
            path: basePath + "/login",
            method: .POST,
            body: try? JSONSerialization.data(withJSONObject: params)
        )
    }
    
    static func refreshToken(token: String) -> Endpoint {
        let params = ["refreshToken": token]
        return Endpoint(
            path: basePath + "/refresh",
            method: .POST,
            body: try? JSONSerialization.data(withJSONObject: params)
        )
    }
    
    static func signOut() -> Endpoint {
        Endpoint(
            path: basePath + "/logout",
            method: .POST
        )
    }
    
    static func getCurrentUser() -> Endpoint {
        Endpoint(
            path: basePath + "/me",
            method: .GET
        )
    }
}
