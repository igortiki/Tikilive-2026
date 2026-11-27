//
//  LiveView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//
//  Portrait                         Landscape (compact height)
//  +---------------------------+    +---------------------------------+
//  | VideoPlayer 16:9          |    |                                 |
//  |   overlay: spinner/error  |    |  VideoPlayer, full screen       |
//  +---------------------------+    |  overlay: spinner/error         |
//  | LiveHeaderView            |    |                                 |
//  +---------------------------+    |  no header, no list,            |
//  | ChannelListView           |    |  no tab bar, no status bar      |
//  |   (scrolls)               |    |                                 |
//  |                           |    +---------------------------------+
//  +---------------------------+
//  | tab bar (from RootView)   |
//  +---------------------------+
//

import SwiftUI
import TikiliveCore
import AVKit

struct LiveView: View {
    
    @State private var selectedChannel: ChannelItem?

    private let playerViewModel: PlayerViewModel

    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private let channelListViewModel: ChannelListViewModel
    private let channelDetailViewModel: ChannelDetailViewModel
    
    // iPhone in landscape reports a compact vertical size class
    private var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    init(channelListViewModel: ChannelListViewModel, channelDetailViewModel: ChannelDetailViewModel, playerViewModel: PlayerViewModel) {
        self.channelListViewModel = channelListViewModel
        self.channelDetailViewModel = channelDetailViewModel
        self.playerViewModel = playerViewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            VideoPlayer(player: playerViewModel.player)
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                // badge first so the error layer covers it
                .overlay(alignment: .topTrailing) {
                    if selectedChannel?.isLive == true {
                        LiveBadgeView()
                            .padding(12)
                    }
                }
                .overlay {
                    let error = channelListViewModel.errorMessage
                        ?? channelDetailViewModel.errorMessage
                        ?? playerViewModel.errorMessage

                    if playerViewModel.isLoading {
                        ProgressView()
                            .controlSize(.large)
                            .tint(.white)
                    } else if let errorMessage = error {
                        ZStack {
                            Color.black
                            Label(errorMessage, systemImage: "exclamationmark.triangle")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                }
                // card in portrait, edge to edge in landscape
                .clipShape(RoundedRectangle(cornerRadius: isLandscape ? 0 : 16))
                .padding(.horizontal, isLandscape ? 0 : 16)

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
                playerViewModel.pause()
                playerViewModel.clear()
                playerViewModel.setLoading(false)
                return
            }
            
            playerViewModel.setLoading(true)
            
            // Stop playback while loading a new channel
            playerViewModel.pause()
            playerViewModel.clear()
            
            await channelDetailViewModel.fetchChannelDetails(id: id)
            
            // a newer channel switch owns the spinner now
            guard !Task.isCancelled else {
                return
            }
            
            guard let url = channelDetailViewModel.channelDetail?.streamURL else {
                // no stream or the request failed: don't spin forever
                playerViewModel.setLoading(false)
                return
            }
            
            playerViewModel.load(url: url)
            playerViewModel.play()
        }
        
        .onAppear {
            playerViewModel.resume()
        }
        
        .onDisappear {
            playerViewModel.pause()
        }
    }
}
