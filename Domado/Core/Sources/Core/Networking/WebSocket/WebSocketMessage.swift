//
//  WebSocketMessage.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

import Foundation

public struct WebSocketMessage<T: Decodable>: Decodable{
    public let type: String
    public let payload: T?
    public let success: Bool
    public let error: WebSocketError?
    public let timestamp: String
    
    public init(type: String, payload: T?, success: Bool, error: WebSocketError?, timestamp: String){
        self.type = type
        self.payload = payload
        self.success = success
        self.error = error
        self.timestamp = timestamp
    }
}
