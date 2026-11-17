//
//  ChannelServiceProtocol.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//

protocol ChannelServiceProtocol: Sendable {
    func fetchVideoChannels() async throws -> [Channel]
    func fetchChannelInfo(channelID: Int) async throws -> ChannelDetail
}
