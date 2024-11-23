//
//  WebSocketError.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

import Foundation

struct WebSocketError: Codable {
    let code: String
    let message: String
}

