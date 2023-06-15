//
//  HexColorExtension.swift
//  Scoreboard - Gully cricket
//
//  Created by sankara velayutham on 14/06/23.
//

import SwiftUI
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
