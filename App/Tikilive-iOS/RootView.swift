//
//  ContentView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 10/30/26
//

import SwiftUI
import TikiliveCore

import SwiftUI

struct RootView: View {
    //private let dependencies: AppDependencies
    @State private var channelListViewModel: ChannelListViewModel
    
    init(dependencies: AppDependencies) {
        //self.dependencies = dependencies
        _channelListViewModel = State(initialValue: dependencies.makeChannelListViewModel())
    }
    
    var body: some View {
        TabView {
            ChannelListView(channelListViewModel: channelListViewModel)
                .tabItem {
                    Label("Live", systemImage: "play.tv")
                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)

            Text("EPG")
                .tabItem {
                    Label("EPG", systemImage: "calendar")
                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    RootView(
        dependencies: AppDependencies(configuration: .tiki6)
    )
}
