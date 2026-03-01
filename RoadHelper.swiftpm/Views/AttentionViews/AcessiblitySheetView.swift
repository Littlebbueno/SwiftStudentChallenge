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
    let impact = UIImpactFeedbackGenerator(style: .light)

    
    init() {
        self._acessibilityChoice = State(initialValue: acessibilityActivated)
        self._eyeChoice = State(initialValue: acessibilityEye)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 25) {
                    VStack(alignment: .leading, spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 65, height: 65)
                                .foregroundStyle(Color("AccessibilityColor").gradient)
                            Image(systemName: "accessibility")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.white)
                        }
                        
                        Text("Accessibility")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 4)
                        
                        Text("This mode lets you choose a 'master eye' to guide tracking. The assistant will focus exclusively on your selected eye to monitor drowsiness, ensuring accurate alerts even if your eyes do not move in sync.")
                            .font(.subheadline)
                            .foregroundStyle(Color.secondary)
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(Color(.secondarySystemGroupedBackground))
                    }
                    Toggle(isOn: $acessibilityChoice.animation(.spring())
                    ){
                        Text("Turn on Accessibility Mode")
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding(.vertical)
                    }
                    .tint(Color.green)
                    .padding(.horizontal)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(.secondarySystemGroupedBackground))
                    }
                    if acessibilityChoice {
                    Text("What eye do you need to the assistant to check while driving?")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                        HStack(spacing: 100) {
                            eyeButton(title: "Left Eye", isRight: false)
                            eyeButton(title: "Right Eye", isRight: true)
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
                    .tint(Color("AccentColorBlue2"))
                    .clipShape(.capsule)
                    .modifier(
                        ConditionalButtonModifierProminent()
                    )
                    
                }
                .padding()
            }
            .dynamicTypeSize(...DynamicTypeSize.accessibility1)
            .navigationTitle("Accessibility Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
                    .tint(Color.primary)
                }
            }
        }
    }
    
    private func eyeButton(title: String, isRight: Bool) -> some View {
        let isSelected = (eyeChoice == isRight)
        
        return Button {
            impact.impactOccurred()
            withAnimation {
                eyeChoice = isRight
            }
        } label: {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color("AccessibilityColor") : Color(.secondarySystemGroupedBackground))
                        .frame(width: 60, height: 60)
                    Image(systemName: "eye.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(isSelected ? .white : .secondary)
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(colorScheme == .dark ? .black: .white, colorScheme == .dark ? .white : .black)
                            .offset(x: 25, y: -20)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .bold : .medium)
                    .foregroundStyle(isSelected ? .primary : .secondary)
            }
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AcessiblitySheetView()
        .preferredColorScheme(ColorScheme.dark)
}
