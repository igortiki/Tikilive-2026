//
//  MockChannelService.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/12/26
//

import Foundation
@testable import TikiliveCore

final class MockChannelService: ChannelServiceProtocol {
    // mutated only from serial @MainActor tests
    nonisolated(unsafe) private(set) var fetchCallCount = 0
    
    let channels: [Channel]
    let error: (any Error)?
    
    init(channels: [Channel], error: (any Error)? = nil) {
        self.channels = channels
        self.error = error
    }
    
    func fetchVideoChannels() async throws -> [Channel] {
        fetchCallCount += 1

        if let error {
            throw error
        }
        
        return channels
    }
    
}
