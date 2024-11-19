//
//  File.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

import Foundation

final class CoreNetworkManager: NetworkManager {
    private let session: URLSession
    private let logger: CoreLogger
    
    init(session: URLSession = .shared, logger: CoreLogger = .shared) {
        self.session = session
        self.logger = logger
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = buildURL(from: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        logger.debug("Requesting URL: \(url)", category: .network)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
        }
        
        logger.debug("Received response: \(httpResponse.statusCode)", category: .network)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingError(underlyingError: error)
        } catch {
            throw NetworkError.unknown(underlyingError: error)
        }
    }
    
    private func buildURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: Environment.Values.baseURL)
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
