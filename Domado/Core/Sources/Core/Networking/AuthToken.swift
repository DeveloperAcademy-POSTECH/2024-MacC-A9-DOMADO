//
//  AuthToken.swift
//  Core 
//
//  Created by 이종선 on 11/19/24.
//

public struct AuthToken: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let tokenType: String
}
