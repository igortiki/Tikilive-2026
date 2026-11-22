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
    
    let error: (any Error)?
    
    let channelDetail: ChannelDetail?
    let channels: [Channel]
    
    init(channels: [Channel], error: (any Error)? = nil, channelDetail: ChannelDetail? = nil) {
        self.channels = channels
        self.channelDetail = channelDetail
        self.error = error
    }
    
    func fetchVideoChannels() async throws -> [Channel] {
        fetchCallCount += 1
        
        if let error {
            throw error
        }
        
        return channels
    }
    
    // returns the configured detail, or throws the configured error
    func fetchChannelInfo(channelID: Int) async throws -> ChannelDetail {
        
        if let error {
            throw error
        }
        
        // only the configured channel exists; any other id fails like a server error
        guard let channelDetail, channelDetail.id == channelID else {
            throw URLError(.badServerResponse)
        }
        
        return channelDetail
    }
}
