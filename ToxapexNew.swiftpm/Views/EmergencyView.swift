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
                let colorText = Color.white
                VStack(spacing: 0) {
                    VStack(spacing: 15) {
                        Image(systemName: emergency.image)
                            .font(.system(size: 60))
                            .foregroundStyle(emergency.color2)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(emergency.steps.enumerated()), id: \.element.id) { index, step in
                            cardEmergencyStep(step: step, index: index, colorText: colorText)
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
                            .init(color: emergency.color2.opacity(0.4), location: 0),
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
                        .padding(.vertical, 10)
                        .padding(.horizontal,18)
                }
                .tint(Color("AlertColor2"))
                .buttonStyle(.glassProminent)
                .padding()
            }
    }
    
    func cardEmergencyStep(step: EmergencyStep, index: Int, colorText: Color) -> some View {
        HStack(alignment: .top, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(step.title)
                        .font(.headline)
                        .foregroundStyle(index == currentStepIndex ? colorText: .primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(index == currentStepIndex ? colorText: .primary)
                        .rotationEffect(.degrees(index == currentStepIndex ? 90 : 0))
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: currentStepIndex)
                }
                
                
                if index == currentStepIndex {
                    if step.stepDescription != "" {
                        Text(step.stepDescription)
                            .font(.subheadline)
                            .foregroundStyle(colorText)
                    }
                    
                    if !step.insideSteps.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(step.insideSteps) { insideStep in
                                HStack(alignment: .top, spacing: 10) {
                                    Circle()
                                        .fill(colorText)
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 6)
                                    
                                    Text(insideStep.stepDescription)
                                        .font(.subheadline)
                                        .foregroundStyle(colorText)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                if insideStep.callStep != ""{
                                    Button{
                                        callNumber(phoneNumber: insideStep.callStep)
                                    }label:{
                                        HStack {
                                            Text("Call: \(insideStep.callStep)")
                                                .padding()
                                                .font(.headline)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 45)
                                        .background((emergency.color == Color("SevereAccident") || emergency.color == Color("VehicleFire"))  ? Color("AlertColor2") : Color("AlertColor2"))
                                        .foregroundStyle(.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 12)
                    }
                    if step.image != ""{
                        Image(step.image)
                            .resizable()
                            .scaledToFill()
                            .containerRelativeFrame(.vertical) { length, axis in
                                length * 0.35
                            }
                            .clipped()
                            .cornerRadius(15)
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
                            .fill(emergency.color2)
                    }
                    else {
                        Rectangle()
                            .fill(Color(.secondarySystemGroupedBackground))
                            .opacity(colorScheme == .dark ? 0.5: 1)
                    }
                }
            }
            .cornerRadius(15)
            .onTapGesture {
                withAnimation{ currentStepIndex = index }
            }
        }
    }

    func callNumber(phoneNumber: String) {
        let cleanNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if let url = URL(string: "tel://\(cleanNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
