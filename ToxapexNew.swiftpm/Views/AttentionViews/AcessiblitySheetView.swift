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

    @Binding var acessibilityChoice: Bool
    @Binding var eyeChoice: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Text("Acessibility Settings")
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
                dismiss()
            } label: {
                Text("Feito")
                    .padding(14)
                    .fontWeight(.bold)
                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                    .frame(maxWidth: .infinity)
                    
            }
            .background {
                LinearGradient(colors: [Color("NoFaceDetected2"), colorScheme == .dark ? Color("OpenEyes2") : Color.pink], startPoint: .leading, endPoint: .trailing)
            }
            .cornerRadius(40)
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
