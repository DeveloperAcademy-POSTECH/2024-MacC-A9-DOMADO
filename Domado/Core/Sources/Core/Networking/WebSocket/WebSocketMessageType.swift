//
//  WebSocketMessageType.swift
//  Core
//
//  Created by 이종선 on 11/23/24.
//

enum WebSocketMessageType: String {
    case completeDocking = "COMPLETE_DOCKING"
    case completeBikeTransfer = "COMPLETE_BIKE_TRANSFER"
    case error = "ERROR"
    case connected = "CONNECTED"
    case disconnected = "DISCONNECTED"
    case emergencyAlert = "EMERGENCY_ALERT"
    case unknown = "UNKNOWN"
}
