//
//  ChannelListView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/11/26
//

import SwiftUI
import TikiliveCore

struct ChannelListView: View {
    private var channelListViewModel: ChannelListViewModel
    
    init(channelListViewModel: ChannelListViewModel) {
        self.channelListViewModel = channelListViewModel
    }
    
    var body: some View {
        
        let _ = Self._printChanges()
        
        Text("Channels: \(channelListViewModel.channels.count)")
            .task {
                print("Live: task started")
                await channelListViewModel.loadChannels()
            }
            
    }
}
