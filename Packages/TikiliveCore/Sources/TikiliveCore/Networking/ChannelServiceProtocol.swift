//
//  ChannelServiceProtocol.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//


protocol ChannelServiceProtocol {
    func fetchVideoChannels() async throws -> [Channel]
}
