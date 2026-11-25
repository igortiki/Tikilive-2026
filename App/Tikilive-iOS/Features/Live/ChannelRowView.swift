//
//  ChannelRowView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//
//  HStack (spacing 16), padding 12, minHeight 60, radius 12
//  +-----------------------------------------+
//  | +--------+                              |
//  | |  logo  |   Channel name               |
//  | +--------+                              |
//  +-----------------------------------------+
//  logo 56x44, radius 8
//  selected: appSelectedCard + appAccent stroke 1.5
//

import SwiftUI
import TikiliveCore

struct ChannelRowView: View {
    private let channel: ChannelItem
    private let isSelected: Bool
    
    init(channel: ChannelItem, isSelected: Bool) {
        self.channel = channel
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack(spacing: 16) {
            CachedAsyncImage(url: channel.logoURL)
                .frame(width: 56, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(channel.name)

            Spacer()

            if isSelected && channel.isLive {
                LiveBadgeView()
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        .background(isSelected ? Color.appSelectedCard : Color.appCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isSelected ? Color.appAccent : Color.clear,
                    lineWidth: 1.5
                )
        }
    }
}
