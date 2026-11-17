//
//  RootView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 10/30/26
//

import SwiftUI
import TikiliveCore

struct RootView: View {
    @State private var channelListViewModel: ChannelListViewModel
    
    init(dependencies: AppDependencies) {
        _channelListViewModel = State(initialValue: dependencies.makeChannelListViewModel())
    }
    
    var body: some View {
        TabView {
            LiveView(channelListViewModel: channelListViewModel)
                .tabItem {
                    Label("Live", systemImage: "play.tv")
                }
                .toolbarBackground(Color.appBackground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)

            Text("EPG")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appBackground)
                .tabItem {
                    Label("EPG", systemImage: "calendar")
                }
                .toolbarBackground(Color.appBackground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
        .tint(Color.appAccent)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView(
        dependencies: AppDependencies(configuration: .tiki6)
    )
}
