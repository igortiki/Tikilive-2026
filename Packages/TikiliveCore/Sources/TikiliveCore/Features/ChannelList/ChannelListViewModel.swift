//
//  ChannelListViewModel.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/3/26
//

import Observation
import Foundation


@MainActor
@Observable

public final class ChannelListViewModel {
    
    private let service: any ChannelServiceProtocol
    public private(set) var errorMessage: String?
    public private(set) var channels: [ChannelItem] = []
    
    init(service: any ChannelServiceProtocol) {
        self.service = service
    }
    
    public func loadChannels() async {
        do {
            let apiChannels = try await service.fetchVideoChannels()
            self.channels = apiChannels.map { ChannelItem(channel: $0) }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
