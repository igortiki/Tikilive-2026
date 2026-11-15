//
//  ChannelRowView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI
import TikiliveCore

struct ChannelRowView: View {
    let channel: ChannelItem

    var body: some View {
        HStack {
            Text(channel.number)
            Text(channel.name)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        .background(Color.appCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
