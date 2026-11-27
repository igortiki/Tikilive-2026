//
//  GuideGridView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/27/26
//
//  +--------+-------------------------------+
//  | corner | TimeRulerView                 |  20:00  20:30  [21:01]  21:30
//  +--------+-------------------------------+
//  | Channel| ProgramGridView               |
//  | Column |   ProgramCellView per event   |
//  | View   |            |                  |
//  | (logos)|            | CurrentTime-     |  overlay over the programs
//  |        |            | IndicatorView    |
//  +--------+-------------------------------+
//  corner = empty, as wide as the logo column, so the ruler starts above the programs
//

import SwiftUI

struct GuideGridView: View {
    private let channelColumnWidth: CGFloat = 72

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: channelColumnWidth)

                TimeRulerView()
            }

            HStack(spacing: 0) {
                ChannelColumnView()
                    .frame(width: channelColumnWidth)

                ProgramGridView()
                    .overlay {
                        CurrentTimeIndicatorView()
                    }
            }
        }
    }
}

#Preview {
    GuideGridView()
        .preferredColorScheme(.dark)
}
