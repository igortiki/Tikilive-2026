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
        // clear the previous failure so a successful reload hides it
        errorMessage = nil

        do {
            let apiChannels = try await service.fetchVideoChannels()
            self.channels = apiChannels.map { ChannelItem(channel: $0) }
        } catch is CancellationError, URLError.cancelled {
            // cancelled by the view, not a real error
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    public func loadChannelsIfNeeded() async {
        guard channels.isEmpty else { return }
        await loadChannels()
    }
}
