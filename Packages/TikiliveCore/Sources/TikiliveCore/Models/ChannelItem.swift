//
//  ChannelItem.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//

import Foundation

// What the app shows for one channel; built only inside the package from the API model
public struct ChannelItem: Identifiable {
    public let id: Int
    public let number: String
    public let name: String
    public let logoURL: URL?
    public let isLive: Bool

    init(channel: Channel) {
        self.id = channel.id
        self.number = String(channel.stbNumber)
        self.name = channel.name
        self.logoURL = channel.img?.small.flatMap { value in
            URL(string: value)
        }
        self.isLive = channel.live
    }
}
