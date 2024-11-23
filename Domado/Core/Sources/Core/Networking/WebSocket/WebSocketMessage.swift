//
//  WebSocketMessage.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

import Foundation

struct WebSocketMessage<T: Codable>: Codable {
    let type: String
    let payload: T?
    let success: Bool
    let error: WebSocketError?
    let timestamp: String
}
