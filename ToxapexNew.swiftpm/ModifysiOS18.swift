//
//  ModifysiOS18.swift
//  Zenith
//
//  Created by Marco Bueno on 27/11/25.
//
import SwiftUI

struct ConditionalButtonModifierProminent: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.buttonStyle(.glassProminent)
        } else {
            content.buttonStyle(.borderedProminent)
        }
    }
}
