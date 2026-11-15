//
//  ChannelListView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/11/26
//

import SwiftUI
import TikiliveCore

struct ChannelListView: View {
    private let channelListViewModel: ChannelListViewModel
    
    init(channelListViewModel: ChannelListViewModel) {
        self.channelListViewModel = channelListViewModel
    }
    
    var body: some View {
        
        let _ = Self._printChanges()
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(channelListViewModel.channels) { channel in
                    ChannelRowView(channel: channel)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .task {
            print("Live: task started")
            await channelListViewModel.loadChannels()
        }
        
    }
}
