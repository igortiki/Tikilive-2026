//
//  RootView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 10/30/26
//
//  +-------------------------------+
//  | TabView                       |
//  |                               |
//  |   selected tab content        |
//  |   (LiveView / GuideView)      |
//  |                               |
//  +---------------+---------------+
//  |    > Live     |  # TV Guide   |  tab bar: appBackground, dark
//  +---------------+---------------+
//  environment: imageLoader, tint appAccent
//

import SwiftUI
import TikiliveCore
import TikiliveUI

struct RootView: View {
    @State private var channelListViewModel: ChannelListViewModel
    @State private var channelDetailViewModel: ChannelDetailViewModel
    @State private var playerViewModel: PlayerViewModel
    
    private let imageLoader: ImageLoader
    
    init(dependencies: AppDependencies) {
        _channelListViewModel = State(initialValue: dependencies.makeChannelListViewModel())
        _channelDetailViewModel = State(initialValue: dependencies.makeChannelDetailViewModel())
        _playerViewModel = State(initialValue: dependencies.makePlayerViewModel())
        self.imageLoader = ImageLoader()
    }
    
    var body: some View {
        TabView {
            LiveView(channelListViewModel: channelListViewModel,
                     channelDetailViewModel: channelDetailViewModel,
                     playerViewModel: playerViewModel)
                .tabItem {
                    Label("Live", systemImage: "play.tv")
                }
                .toolbarBackground(Color.appBackground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)

            GuideView()
                .tabItem {
                    Label("TV Guide", systemImage: "calendar")
                }
                .toolbarBackground(Color.appBackground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
        .environment(\.imageLoader, imageLoader)
        .tint(Color.appAccent)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView(
        dependencies: AppDependencies(configuration: .tiki6)
    )
}
