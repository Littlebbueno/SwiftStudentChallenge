//
//  EmergencieView.swift
//  Toxapex
//
//  Created by Marco Bueno on 14/01/26.
//

import SwiftUI

struct EmergencyView: View {
    var emergency: Emergency
    @State private var currentStepIndex = 0
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 15) {
                        Image(systemName: emergency.image)
                            .font(.system(size: 60))
                            .foregroundStyle(emergency.color)
                            .shadow(color: emergency.color.opacity(0.5), radius: 10)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(emergency.steps.enumerated()), id: \.element.id) { index, step in
                            cardEmergencyStep(step: step, index: index)
                        }
                    }
                    .padding()
                    
                }
            }
            .background {
                ZStack {
                    Color(.systemGroupedBackground)
                    LinearGradient(
                        stops: [
                            .init(color: emergency.color.opacity(0.4), location: 0),
                            .init(color: .clear, location: 0.6)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .ignoresSafeArea()
            }
//            .toolbarVisibility(.hidden, for: .tabBar)
            .navigationTitle(emergency.title)
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                Button{
                    if currentStepIndex < emergency.steps.count - 1 {
                        withAnimation {
                            currentStepIndex += 1
                        }
                    }
                }label:{
                    Text("Next Step")
                        .font(.headline)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                }
                .tint(Color("AlertColor2"))
                .buttonStyle(.glassProminent)
                .padding()
            }
    }
    
    func cardEmergencyStep(step: EmergencyStep, index: Int) -> some View {
        HStack(alignment: .top, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 8) {
                if emergency.color == Color("AnimalHit") && colorScheme == .dark {
                    Text(step.title)
                        .font(.headline)
                        .foregroundStyle(index == currentStepIndex ? .black : .primary)
                }else {
                    Text(step.title)
                        .font(.headline)
                        .foregroundStyle(index == currentStepIndex ? .white : .primary)
                }
                
                if index == currentStepIndex {
                    if emergency.color == Color("AnimalHit") && colorScheme == .dark {
                        Text(step.stepDescription)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    } else {
                        Text(step.stepDescription)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background{
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                    if index == currentStepIndex {
                        Rectangle()
                            .fill(emergency.color)
                    }
                    else {
                        Rectangle()
                            .fill(Color(.secondarySystemGroupedBackground))
                            .opacity(colorScheme == .dark ? 0.5: 1)
                    }
                }
            }
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(index == currentStepIndex ? .white.opacity(0.5) : .clear, lineWidth: 0.5)
            )
            .onTapGesture {
                withAnimation{ currentStepIndex = index }
            }
        }
    }

//    func stepIndicator(index: Int) -> some View {
//        VStack {
//            Circle()
//                .fill(index <= currentStepIndex ? emergency.color : Color.gray.opacity(0.3))
//                .frame(width: 28, height: 28)
//                .overlay(Text("\(index + 1)").font(.caption2).bold().foregroundStyle(.white))
//            
//            if index < emergency.steps.count - 1 {
//                Rectangle()
//                    .fill(index < currentStepIndex ? emergency.color : Color.gray.opacity(0.3))
//                    .frame(width: 2, height: 60)
//            }
//        }
//    }
}
