//
//  Endpoint.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

import Foundation

/// 네트워크 요청의 엔드포인트 정보를 정의하는 구조체입니다.
public struct Endpoint {
    /// API의 특정 경로를 나타냅니다.
    public let path: String
    
    /// HTTP 요청 메서드를 나타냅니다
    public let method: HTTPMethod
    
    /// URL 쿼리 파라미터를 나타냅니다.
    public let queryItems: [URLQueryItem]?
    
    /// HTTP 요청 헤더를 나타냅니다.
    public var headers: [String: String]?
    
    /// HTTP 요청의 본문에 포함될 데이터를 나타냅니다.
    public let body: Data?
    
    public init(
        path: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
