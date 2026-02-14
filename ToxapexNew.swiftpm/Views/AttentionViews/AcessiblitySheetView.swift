//
//  AcessiblitySheetView.swift
//  Toxapex
//
//  Created by Marco Bueno on 11/02/26.
//

import SwiftUI

struct AcessiblitySheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    // false = off, true = on
    @AppStorage("acessibilityMode") var acessibilityActivated: Bool = false
    // false = left, true = right
    @AppStorage("acessibilityEye") var acessibilityEye: Bool = false
    
    @State var eyeChoice: Bool = false
    @State var acessibilityChoice: Bool = false
    
    init() {
        self._acessibilityChoice = State(initialValue: acessibilityActivated)
        self._eyeChoice = State(initialValue: acessibilityEye)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Text("Accessibility Settings")
                .font(.headline)
            
            Text("Hello, here you can configure your attention assistant to your need.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
            
            Toggle("Accessibility Mode", isOn: $acessibilityChoice.animation(.spring()))
                .tint(Color("AccentColor"))
            
            if acessibilityChoice {
                VStack(spacing: 15) {
                    Text("What eye do you need to the assistant to check while driving?")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 20) {
                        eyeButton(title: "Left Eye", isRight: false)
                        eyeButton(title: "Right Eye", isRight: true)
                    }
                }
                .transition(.opacity.combined(with: .scale))
            }
            
            Spacer()
            
            Button {
                self.acessibilityActivated = self.acessibilityChoice
                self.acessibilityEye = self.eyeChoice
                dismiss()
            } label: {
                Text("Done")
                    .padding(.vertical, 8)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .containerRelativeFrame(.horizontal) { length, axis in
                        0.5 * length
                    }
                    
            }
            .tint(Color("AccentColor2"))
            .buttonStyle(.glassProminent)
        }
        .padding(30)
    }
    
    private func eyeButton(title: String, isRight: Bool) -> some View {
        Button {
            eyeChoice = isRight
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
        }
        .tint(eyeChoice == isRight ? .blue : .gray.opacity(0.3))
        .buttonStyle(.borderedProminent)
    }
}
