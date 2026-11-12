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
    private let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    var body: some View {
        ChannelListView(channelListViewModel: dependencies.makeChannelListViewModel())
    }
}

#Preview {
    RootView(
        dependencies: AppDependencies(configuration: .tiki6)
    )
}
