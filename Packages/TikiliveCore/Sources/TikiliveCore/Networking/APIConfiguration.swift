//
//  APIConfiguration.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 10/31/26
//

import Foundation

public struct APIConfiguration: Sendable {
    let baseURL: URL
    let apiID: String
    let apiKey: String

    init(baseStringURL: String, apiID: String, apiKey: String) {
        guard let baseURL = URL(string: baseStringURL) else {
            preconditionFailure("Invalid BaseURL \(baseStringURL)")
        }
        self.baseURL = baseURL
        self.apiID = apiID
        self.apiKey = apiKey
    }
}

public extension APIConfiguration {
    static let tiki6 = APIConfiguration(baseStringURL: "https://tiki6.tikilive.com", apiID: "13", apiKey: "KDwnVdWzMx6zAkJo")
    static let prod = APIConfiguration(baseStringURL: "https://www.tikilive.com", apiID: "10", apiKey: "<your api key>")
}
