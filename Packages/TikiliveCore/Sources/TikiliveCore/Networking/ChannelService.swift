//
//  ChannelService.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//

import Foundation

final class ChannelService: ChannelServiceProtocol {
    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func fetchVideoChannels() async throws -> [Channel] {
        let queryItems = [
            URLQueryItem(name: "mobile_streams_only", value: "1"),
            URLQueryItem(name: "order_by", value: "stb_number"),
            URLQueryItem(name: "direction", value: "asc"),
            URLQueryItem(name: "limit", value: "1000"),
            URLQueryItem(name: "channel_type", value: "all"),
            URLQueryItem(name: "include_tveverywhere_channels", value: "1"),
            URLQueryItem(name: "include_sling_channels", value: "1"),
            URLQueryItem(name: "ios_available", value: "1"),
            URLQueryItem(name: "premium_broadcasts", value: "1"),
        ]

      
        let response: ChannelsResponse = try await client.request(path: "/channels", queryItems: queryItems)
        return response.channels
    }
}
