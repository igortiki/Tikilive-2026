//
//  ChannelDetailItem.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/21/26
//

import Foundation

public struct ChannelDetailItem {
    public let id: Int
    public let name: String
    public let description: String
    // nil when there is neither a stream nor a preview
    public let streamURL: URL?
    public let isHD: Bool

    init(channelDetails: ChannelDetail) {
        self.id = channelDetails.id
        self.name = channelDetails.name
        self.description = channelDetails.description
        // full stream if the guest has access, otherwise the free preview
        let stream = channelDetails.sources?.hls ?? channelDetails.previewHLSStream
        self.streamURL = stream.flatMap { value in
            URL(string: value)
        }
        self.isHD = channelDetails.isHD
    }
}
