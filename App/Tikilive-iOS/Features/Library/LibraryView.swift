//
//  LibraryView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/27/26
//
//  +-------------------------------+
//  |                               |
//  |       Video Library           |  placeholder: video on demand
//  |                               |
//  +-------------------------------+
//

import SwiftUI

struct LibraryView: View {

    var body: some View {
        Text("LibraryView")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
    }
}

#Preview {
    LibraryView()
        .preferredColorScheme(.dark)
}
