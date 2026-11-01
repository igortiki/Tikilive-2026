
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
}

