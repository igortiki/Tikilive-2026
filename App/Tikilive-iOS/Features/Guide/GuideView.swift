//
//  GuideView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/27/26
//
//  +-------------------------------+
//  | GuideHeaderView               |  "TV Guide"
//  +-------------------------------+
//  | GuideDateSelectorView         |  Today / Tomorrow / Fri ... calendar
//  +-------------------------------+
//  | ChannelFilterView             |  All Channels / News / Sports ...
//  +-------------------------------+
//  | GuideGridView                 |
//  |   (ruler, logos, programs,    |
//  |    current time line)         |
//  |                  [ Now ]      |  CurrentTimeButtonView, overlay
//  +-------------------------------+
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack(spacing: 0) {
            GuideHeaderView()

            GuideDateSelectorView()

            ChannelFilterView()

            GuideGridView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.appBackground)
        .overlay(alignment: .bottomTrailing) {
            CurrentTimeButtonView()
        }
    }
}

#Preview {
    GuideView()
        .preferredColorScheme(.dark)
}
