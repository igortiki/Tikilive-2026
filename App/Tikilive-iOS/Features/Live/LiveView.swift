//
//  LiveView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI
import TikiliveCore

struct LiveView: View {
    @State private var selectedChannel: ChannelItem?
    private let channelListViewModel: ChannelListViewModel

    init(channelListViewModel: ChannelListViewModel) {
        self.channelListViewModel = channelListViewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray)
                .aspectRatio(16.0 / 9.0, contentMode: .fit)

            LiveHeaderView(channel: selectedChannel)
            ChannelListView(channelListViewModel: channelListViewModel, selectedChannel: $selectedChannel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.appBackground)
    }
}
