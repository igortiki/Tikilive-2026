//
//  ChannelDetailViewModel.swift.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/21/26
//

import Foundation

@MainActor
@Observable

public final class ChannelDetailViewModel {
    private let service: any ChannelServiceProtocol
    public private(set) var errorMessage: String?
    public private(set) var channelDetail: ChannelDetailItem?
    
    init(service: any ChannelServiceProtocol) {
        self.service = service
    }
    
    public func fetchChannelDetails(id: Int) async {
        // drop the previous channel so a failed load can't replay its stream
        channelDetail = nil
        errorMessage = nil

        do {
            let response = try await service.fetchChannelInfo(channelID: id)
            channelDetail = ChannelDetailItem(channelDetails: response)
        } catch is CancellationError, URLError.cancelled {
            // cancelled by the view, not a real error
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}



