//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

import Foundation

public struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: TimeInterval
    
    public init(accessToken: String, refreshToken: String, expiresIn: TimeInterval) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}
