//
//  RequestSigner.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 10/31/26
//

import CryptoKit
import Foundation

struct RequestSigner {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    // Returns the Authorization header value for one request
    func authorizationHeader(method: String, path: String, authKey: String) -> String {
        // 1. Build the string to sign, e.g. "GET:/api/123/channels?limit=5:<guest>"
        let message = "\(method):\(path):\(authKey)"

        // 2. Sign it with HMAC-SHA256 keyed by apiKey (32 bytes)
        let key = SymmetricKey(data: Data(apiKey.utf8))
        let code = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: key)

        // 3. Turn the 32 bytes into a 64-char lowercase hex token, e.g. "2934b6fb..."
        let token = code.map { String(format: "%02x", $0) }.joined()

        // 4. Pack "authKey:token" as Basic auth, e.g. "Basic PGd1ZXN0Pjoy..."
        let credentials = Data("\(authKey):\(token)".utf8).base64EncodedString()
        return "Basic \(credentials)"
    }
}
