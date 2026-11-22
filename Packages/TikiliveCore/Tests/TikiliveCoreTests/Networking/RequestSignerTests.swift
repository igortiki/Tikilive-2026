//
//  RequestSignerTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//

import Testing

@testable import TikiliveCore


@Test
func authorizationHeaderReturnsExpectedSignature() {
    // Arrange — prepare test data
    let signer = RequestSigner(apiKey: "test-key")
    let method = "GET"
    let path = "/api/123/channels?limit=5"
    let authKey = "<guest>"

    // Act — execute the method
    let result = signer.authorizationHeader(method: method, path: path, authKey: authKey)
    
    // Assert — verify the result
    let expected = "Basic PGd1ZXN0PjoyOTM0YjZmYmExMTExNTliNTVmY2IxNDczZTQwMDVmOWE4YzRmZjczNDliZDY2ZjhhMmE3NGQxMGQyYjkxNWNk"
    #expect(result == expected)
}
