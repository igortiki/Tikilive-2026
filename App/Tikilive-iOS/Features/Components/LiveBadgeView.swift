//
//  LiveBadgeView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/25/26
//

import SwiftUI

struct LiveBadgeView: View {

    var body: some View {
        Text("LIVE")
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.appLive)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }

}
