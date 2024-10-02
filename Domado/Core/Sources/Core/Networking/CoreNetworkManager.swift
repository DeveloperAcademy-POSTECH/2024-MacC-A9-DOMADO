//
//  File.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

import Foundation
import Combine

/// `NetworkManager` 프로토콜을 채택하여 네트워크 요청을 처리하는 클래Type스입니다.
/// `NetworkError`를 사용하여 에러를 일관되게 처리합니다.
final class CoreNetworkManager: NetworkManager {
    /// `URLSession` 인스턴스를 사용하여 네트워크 요청을 수행합니다.
    private let session: URLSession
    
    /// 로깅을 담당하는 `CoreLogger` 인스턴스입니다.
    private let logger: CoreLogger
    
    /// `CoreNetworkManager`의 초기화 메서드입니다.
    ///
    /// - Parameters:
    ///   - session: 네트워크 요청을 수행할 `URLSession` 인스턴스. 기본값은 `.shared`입니다.
    ///   - logger: 로깅을 담당할 `CoreLogger` 인스턴스. 기본값은 `.shared`입니다.
    init(session: URLSession = .shared, logger: CoreLogger = .shared) {
        self.session = session
        self.logger = logger
    }
    
    /// 주어진 엔드포인트로 네트워크 요청을 수행하고, 결과를 퍼블리셔로 반환합니다.
    ///
    /// - Parameter endpoint: 요청을 구성하는 엔드포인트 정보.
    /// - Returns: 디코딩된 타입의 데이터를 퍼블리셔로 반환합니다.
    public func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        // URL 구성
        guard let url = buildURL(from: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        // URLRequest 구성
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        // 요청 로깅
        logger.debug("Requesting URL: \(url)", category: .network)
        
        // 네트워크 요청 수행
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background)) // 백그라운드 스레드에서 수행
            .tryMap { [weak self] result -> Data in
                // HTTP 응답 검증
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                // 성공적인 HTTP 상태 코드 (200...299) 검증
                if !(200...299).contains(httpResponse.statusCode) {
                    let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
                }
                
                // 응답 로깅
                self?.logger.debug("Received response: \(httpResponse.statusCode)", category: .network)
                
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder()) // 응답 데이터 디코딩
            .mapError { error -> NetworkError in
                // 발생한 에러를 `NetworkError`로 매핑
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(underlyingError: decodingError)
                } else if (error as NSError).domain == NSURLErrorDomain {
                    return NetworkError.requestFailed(underlyingError: error)
                } else {
                    return NetworkError.unknown(underlyingError: error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// `Endpoint`로부터 전체 URL을 구성합니다.
    ///
    /// - Parameter endpoint: URL을 구성할 엔드포인트 정보.
    /// - Returns: 전체 URL. 구성에 실패하면 `nil`을 반환합니다.
    private func buildURL(from endpoint: Endpoint) -> URL? {
        // MARK: 환경변수 주입고려
        var components = URLComponents(string: "https://api.example.com")
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
