
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
    
    init(configuration: APIConfiguration, session: URLSession = .shared) {
        self.configuration = configuration
        self.session = session
    }
}

