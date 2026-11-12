//
//  MockChannelService.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/12/26
//

import Foundation
@testable import TikiliveCore

final class MockChannelService: ChannelServiceProtocol {
    
    let channels: [Channel]
    let error: (any Error)?
    
    init(channels: [Channel], error: (any Error)? = nil) {
        self.channels = channels
        self.error = error
    }
    
    func fetchVideoChannels() async throws -> [Channel] {
        if let error {
            throw error
        }
        
        return channels
    }
    
}
