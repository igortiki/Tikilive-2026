//
//  LiveHeaderView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/16/26
//

import SwiftUI

struct LiveHeaderView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("National Geographic")
                .font(.title2.bold())
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
