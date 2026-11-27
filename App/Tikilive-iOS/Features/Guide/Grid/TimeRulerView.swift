//
//  TimeRulerView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/27/26
//
//  +--------------------------------------------+
//  | 20:00     20:30   [21:01]   21:30    22:00 |
//  |   |         |        |        |        |   |  ticks continue down the grid
//  +--------------------------------------------+
//  top row of GuideGridView, right of the empty corner;
//  [21:01] = current time plaque, scrolls horizontally with the programs
//

import SwiftUI

struct TimeRulerView: View {

    var body: some View {
        VStack {
            Text("TimeRulerView")
        }
    }
}
