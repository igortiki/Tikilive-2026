//
//  LiveView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI
import TikiliveCore
import AVKit
import Combine

struct LiveView: View {

    @State private var selectedChannel: ChannelItem?
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    private let channelListViewModel: ChannelListViewModel
    private let channelDetailViewModel: ChannelDetailViewModel

    // iPhone in landscape reports a compact vertical size class
    private var isLandscape: Bool {
        verticalSizeClass == .compact
    }

    // empty until the selected channel's stream is loaded
    @State private var player = AVPlayer()
    // true from the channel switch until the video actually plays
    @State private var isLoading = false

    init(channelListViewModel: ChannelListViewModel, channelDetailViewModel: ChannelDetailViewModel) {
        self.channelListViewModel = channelListViewModel
        self.channelDetailViewModel = channelDetailViewModel
    }

    var body: some View {
        VStack(spacing: 0) {

            VideoPlayer(player: player)
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .controlSize(.large)
                            .tint(.white)
                    }
                }
                .ignoresSafeArea(edges: isLandscape ? .all : [])

            if !isLandscape {
                LiveHeaderView(channel: selectedChannel)
                ChannelListView(channelListViewModel: channelListViewModel, selectedChannel: $selectedChannel)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(isLandscape ? Color.black : Color.appBackground)
        .toolbar(isLandscape ? .hidden : .visible, for: .tabBar)
        .statusBarHidden(isLandscape)

        .task(id: selectedChannel?.id) {
            guard let id = selectedChannel?.id else {
                player.pause()
                player.replaceCurrentItem(with: nil)
                isLoading = false
                return
            }

            isLoading = true

            // Stop playback while loading a new channel
            player.pause()
            player.replaceCurrentItem(with: nil)

            await channelDetailViewModel.fetchChannelDetails(id: id)

            // a newer channel switch owns the spinner now
            guard !Task.isCancelled else {
                return
            }

            guard let url = channelDetailViewModel.channelDetail?.streamURL else {
                // no stream or the request failed: don't spin forever
                isLoading = false
                return
            }


            player.replaceCurrentItem(with: AVPlayerItem(url: url))
            player.play()
        }

        // AVPlayer isn't @Observable, so its status comes through KVO
        .onReceive(player.publisher(for: \.timeControlStatus).receive(on: RunLoop.main)) { status in
            if status == .playing {
                isLoading = false
            }
        }
        .onAppear {
            guard player.currentItem != nil else {
                return
            }

            player.play()
        }

        .onDisappear {
            player.pause()
        }
    }
}
