//
//  Color+Hex.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 11/15/26
//

import SwiftUI

extension Color {
    // 0xRRGGBB -> Color
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF)
        let green = Double((hex >> 8) & 0xFF)
        let blue = Double(hex & 0xFF)

        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}
