//
//  NetworkManager.swift
//  Core
//
//  Created by 이종선 on 9/30/24.
//

import Combine

/// 네트워크 요청을 처리하는 매니저의 기본 프로토콜입니다.
public protocol NetworkManager {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
