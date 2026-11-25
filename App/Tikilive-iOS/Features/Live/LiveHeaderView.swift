//
//  LiveHeaderView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/16/26
//
//  +-----------------------------------+
//  | Channel name  (title2, bold)      |  padding 16
//  | "Select a channel" when nil       |
//  +-----------------------------------+
//

import SwiftUI
import TikiliveCore

struct LiveHeaderView: View {
    private let channel: ChannelItem?

    init(channel: ChannelItem?) {
        self.channel = channel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(channel?.name ?? "Select a channel")
                .font(.title2.bold())
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
