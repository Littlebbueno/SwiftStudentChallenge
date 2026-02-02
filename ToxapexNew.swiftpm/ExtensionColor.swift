//
//  ExtensionColor.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//

import SwiftUI
// Extensão para misturar 2 cores
extension Color {

    func components() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue, alpha)
        }
        return nil
    }

    func blend(with otherColor: Color, ratio: CGFloat = 0.5) -> Color? {
        let finalRatio = max(0, min(1, ratio))
        let currentRatio = 1.0 - finalRatio

        guard let components1 = self.components(),
              let components2 = otherColor.components() else {
            return nil
        }
        
        let red = components1.red * currentRatio + components2.red * finalRatio
        let green = components1.green * currentRatio + components2.green * finalRatio
        let blue = components1.blue * currentRatio + components2.blue * finalRatio
        let alpha = components1.alpha * currentRatio + components2.alpha * finalRatio
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
