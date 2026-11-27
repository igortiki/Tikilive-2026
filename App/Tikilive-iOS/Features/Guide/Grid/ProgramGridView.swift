//
//  ProgramGridView.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/27/26
//
//  +---------------+---+---------------+---------+
//  | Wild Africa   |   | Planet Earth  |   ...   |  one row per channel
//  | 20:00 - 20:45 |   | 21:00 - 22:00 |         |  gap 20:45 - 21:00
//  +---------------+---+---------------+---------+
//  | How It's Made     | Mega Factories          |
//  | 20:00 - 21:00     | 21:00 - 22:00           |
//  +-------------------+-------------------------+
//  ProgramCellView per event: x = start time, width = duration;
//  the cell on air gets a progress bar; gaps stay empty
//

import SwiftUI

struct ProgramGridView: View {

    var body: some View {
        VStack {
            Text("ProgramGridView")
        }
    }
}
