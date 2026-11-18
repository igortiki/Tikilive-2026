//
//  ChannelRowView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI
import TikiliveCore
import TikiliveUI

struct ChannelRowView: View {
    private let channel: ChannelItem
    private let isSelected: Bool
    private let imageLoader: ImageLoader
    
    init(channel: ChannelItem, isSelected: Bool, imageLoader: ImageLoader) {
        self.channel = channel
        self.isSelected = isSelected
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        HStack(spacing: 16) {
            CachedAsyncImage(url: channel.logoURL, imageLoader: imageLoader)
                .frame(width: 56, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(channel.name)
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
