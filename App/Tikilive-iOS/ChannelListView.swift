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
        Text("Channel List")
            .onAppear {
                Task {
                    await channelListViewModel.loadChannels()
                }
            }
    }
}
