//
//  LiveView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI
import TikiliveCore
import TikiliveUI
import AVKit

struct LiveView: View {
    @State private var selectedChannel: ChannelItem?
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    private let imageLoader: ImageLoader

    // iPhone in landscape reports a compact vertical size class
    private var isLandscape: Bool {
        verticalSizeClass == .compact
    }

    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    private let channelListViewModel: ChannelListViewModel

    init(channelListViewModel: ChannelListViewModel, imageLoader: ImageLoader) {
        self.channelListViewModel = channelListViewModel
        self.imageLoader = imageLoader
    }

    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                .ignoresSafeArea(edges: isLandscape ? .all : [])

            if !isLandscape {
                LiveHeaderView(channel: selectedChannel)
                ChannelListView(channelListViewModel: channelListViewModel, selectedChannel: $selectedChannel, imageLoader: imageLoader)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(isLandscape ? Color.black : Color.appBackground)
        .toolbar(isLandscape ? .hidden : .visible, for: .tabBar)
        .statusBarHidden(isLandscape)
        .onAppear {
            player.play()
        }
        .onDisappear {
            player.pause()
        }
    }
}
