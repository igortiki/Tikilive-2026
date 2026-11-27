//
//  SessionStoreTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/27/26
//

import Testing

@testable import TikiliveCore

@Suite
struct SessionStoreTests {

    // MARK: - Tests

    @Test
    func newStoreIsGuest() {
        // Arrange
        let store = SessionStore()

        // Act
        let isAuthenticated = store.isAuthenticated

        // Assert
        #expect(isAuthenticated == false)
    }
}
