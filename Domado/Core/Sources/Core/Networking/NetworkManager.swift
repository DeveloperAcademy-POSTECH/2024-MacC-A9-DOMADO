//
//  NetworkManager.swift
//  Core
//
//  Created by 이종선 on 9/30/24.
//

import Combine

/// 네트워크 요청을 처리하는 매니저의 기본 프로토콜입니다.
/// `NetworkError`를 사용하여 에러를 처리합니다.
public protocol NetworkManager {
    /// 주어진 엔드포인트로 네트워크 요청을 수행하고, 결과를 퍼블리셔로 반환합니다.
    ///
    /// - Parameter endpoint: 요청을 구성하는 엔드포인트 정보.
    /// - Returns: 디코딩된 타입의 데이터를 퍼블리셔로 반환합니다.
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

