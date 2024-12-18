//
//  ColorUtils.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (colorString.hasPrefix("#")) {
            colorString.remove(at: colorString.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgb)

        self.init(
            red: Double(Double(rgb & 0xFF0000 >> 16) / 255.0),
            green: Double(Double(rgb & 0x00FF00 >> 8) / 255.0),
            blue: Double(Double(rgb & 0x0000FF) / 255.0)
        )
    }
}
