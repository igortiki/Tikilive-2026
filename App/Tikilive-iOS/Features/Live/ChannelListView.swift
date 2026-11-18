//
//  ChannelListView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/11/26
//

import SwiftUI
import TikiliveCore

struct ChannelListView: View {
    @Binding var selectedChannel: ChannelItem?
    private let channelListViewModel: ChannelListViewModel
    private let imageLoader: ImageLoader

    init(channelListViewModel: ChannelListViewModel, selectedChannel: Binding<ChannelItem?>, imageLoader: ImageLoader) {
        self.channelListViewModel = channelListViewModel
        self._selectedChannel = selectedChannel
        self.imageLoader = imageLoader
    }

    var body: some View {
        let _ = Self._printChanges()

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(channelListViewModel.channels) { channel in
                    Button {
                        selectedChannel = channel
                    } label: {
                        ChannelRowView(channel: channel, isSelected: selectedChannel?.id == channel.id, imageLoader: imageLoader)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .task {
            // first appearance: load once, skip when returning to the tab
            await channelListViewModel.loadChannelsIfNeeded()
            syncSelection()
        }
        .refreshable {
            // pull to refresh: always reload
            await channelListViewModel.loadChannels()
            syncSelection()
        }
    }

    // keep the selected channel if it is still in the list, otherwise pick the first
    private func syncSelection() {
        if let selectedChannel, let updatedChannel = channelListViewModel.channels.first(where: { $0.id == selectedChannel.id }) {
            self.selectedChannel = updatedChannel
        } else {
            self.selectedChannel = channelListViewModel.channels.first
        }
    }
}
