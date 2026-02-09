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
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollViewReader { proxy in
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
                                .id(index)
                        }
                    }
                    .padding()
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
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
            .onChange(of: self.currentStepIndex) { _, newValue in
                withAnimation(.easeInOut) {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
    
    func cardEmergencyStep(step: EmergencyStep, index: Int, colorText: Color) -> some View {
        HStack(alignment: .top, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(step.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(index == currentStepIndex ? colorText: .primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(index == currentStepIndex ? colorText: .primary)
                        .rotationEffect(.degrees(index == currentStepIndex ? 90 : 0))
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: currentStepIndex)
                        .onTapGesture {
                            if currentStepIndex == index {
                                withAnimation { currentStepIndex = -1 }
                            }
                            else {
                                withAnimation{ currentStepIndex = index }
                            }
                        }
                }
                
                
                if index == currentStepIndex {
                    if step.stepDescription != "" {
                        Text(step.stepDescription)
                            .fontWeight(.medium)
                            .font(.subheadline)
                            .foregroundStyle(colorText)
                    }
                    
                    if step.warning != "" && step.warningBefore == true{
                        HStack(alignment: .center ,spacing: 20) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.red)
                            Text(step.warning)
                                .foregroundStyle(.red)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .opacity(0.86)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.top, 2)
                    }
                    
                    if !step.insideSteps.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(step.insideSteps) { insideStep in
                                if insideStep.stepDescription == "Move the lower jaw forward without tilting the head back to protect the neck." {
                                    Text("Methods to clear the Airways:")
                                        .fontWeight(.medium)
                                        .font(.subheadline)
                                        .foregroundStyle(colorText)
                                        .offset(x: -12)
                                        .padding(.top, 4)
                        
                                }
                                HStack(alignment: .top, spacing: 10) {
                                    Circle()
                                        .fill(colorText)
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 6)
                                    if insideStep.title != ""{
                                        Text("\(Text(insideStep.title).bold()) \(insideStep.stepDescription)")
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .foregroundStyle(colorText)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }else{
                                        Text(insideStep.stepDescription)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .foregroundStyle(colorText)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                if insideStep.callStep != ""{
                                    Button{
                                        callNumber(phoneNumber: insideStep.callStep)
                                    }label:{
                                        HStack {
                                            Text("Call: \(insideStep.callStep)")
                                                .padding()
                                                .font(.headline)
                                                .fontWeight(.bold)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 45)
                                        .background((emergency.color == Color("SevereAccident") || emergency.color == Color("VehicleFire"))  ? Color("AlertColor3") : Color("AlertColor2"))
                                        .foregroundStyle(.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 12)
                    }
                    if step.warning != "" && step.warningBefore == false{
                        HStack(alignment: .center ,spacing: 20) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.red)
                            Text(step.warning)
                                .foregroundStyle(.red)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .opacity(0.86)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.top, 2)
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
                            .padding(.top, 6)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                    }
                    if step.specificAnimation == true {
                        if emergency.color == Color("Medical") || emergency.color == Color("CPREmergency"){
                            CPRAnimationView()
                                .padding(40)
                        }
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
                if currentStepIndex != index {
                    withAnimation{ currentStepIndex = index }
                }
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

