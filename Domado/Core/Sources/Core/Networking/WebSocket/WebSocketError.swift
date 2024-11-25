//
//  WebSocketError.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

import Foundation

public struct WebSocketError: Codable {
    public let code: String
    public let message: String
}

