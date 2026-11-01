
//
//  APIClient.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 10/31/26
//

import Foundation

final class APIClient {
    let configuration: APIConfiguration
    private let session: URLSession
    private let signer: RequestSigner
    
    init(configuration: APIConfiguration, session: URLSession = .shared) {
        self.configuration = configuration
        self.session = session
        self.signer = RequestSigner(apiKey: configuration.apiKey)
    }
    
    // MARK: - Generic Request
    func request<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        let method = "GET"
        let url = configuration.baseURL
            .appending(path: "api")
            .appending(path: configuration.apiID)
            .appending(path: path)
            .appending(queryItems: queryItems)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        // Sign exactly what goes on the wire: path plus query, no host
        var signedPath = url.path(percentEncoded: true)
        if let query = url.query(percentEncoded: true) {
            signedPath += "?" + query
        }
        // Guest until login exists
        let authorization = signer.authorizationHeader(method: method, path: signedPath, authKey: "<guest>")
        urlRequest.setValue(authorization, forHTTPHeaderField: "Authorization")

        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Models map snake_case keys with explicit CodingKeys
        return try JSONDecoder().decode(T.self, from: data)
    }
        
}


