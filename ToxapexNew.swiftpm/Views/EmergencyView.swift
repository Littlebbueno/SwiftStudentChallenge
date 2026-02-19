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
    let impact = UIImpactFeedbackGenerator(style: .light)
    @Environment(\.colorScheme) var colorScheme
    @Binding var path : [navigationPath]

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
                ToolbarItem(placement: .topBarTrailing) {
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
                    impact.impactOccurred()
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
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if currentStepIndex == index {
                        withAnimation { currentStepIndex = -1 }
                    }
                    else {
                        impact.impactOccurred()
                        withAnimation{ currentStepIndex = index }
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
                                    .environment(\.colorScheme, .dark)
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.black)
                                    .opacity(0.6)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.top, 2)
                    }
                    
                    if !step.insideSteps.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(step.insideSteps) { insideStep in
                                if let linkTo = insideStep.linkTo {
                                    cardToOtherView(linkTo: linkTo)
                                        .padding(.bottom, 8)
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
                                    if insideStep.callStep == "Emergency Contacts"{
                                        NavigationLink(destination: EmergencyContactsView()) {
                                            HStack {
                                                Text("Emergency Contacts")
                                                    .padding()
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 45)
                                            .background(.white)
                                            .foregroundStyle(.black)
                                            .cornerRadius(10)
                                            .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                                        }
                                        .padding(.vertical, 4)
                                    }else {
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
                                            .background((emergency.color == Color("DisabledVehicle") || emergency.color == Color("VehicleFire") || emergency.color == Color("Overheating"))  ? Color("AlertColor3") : Color("AlertColor2"))
                                            .foregroundStyle(.white)
                                            .cornerRadius(10)
                                            .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                                if insideStep.image != "" {
                                    Image(insideStep.image)
                                        .resizable()
                                        .scaledToFill()
                                        .containerRelativeFrame(.vertical) { length, axis in
                                            length * 0.30
                                        }
                                        .clipped()
                                        .cornerRadius(15)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 8)
                                }
                            }
                        }
                        .padding(.leading, 4)
                    }
                    if step.specificAnimation == true {
                        if emergency.color == Color("CPREmergency"){
                            CPRAnimationView()
                                .padding(40)
                        }
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
                                    .environment(\.colorScheme, .dark)

                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.black)
                                    .opacity(0.6)
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
                    if let linkTo = step.linkTo{
                        cardToOtherView(linkTo: linkTo)
                            .padding(.top, 10)
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
    
    func cardToOtherView(linkTo: navigationPath) -> some View{
        Button{
            self.path.append(linkTo)
        }label: {
            if linkTo == navigationPath.cpr {
                HStack {
                    Text("CPR Resuscitation")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color("CPREmergency3"))
                .foregroundStyle(.black)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            }
            if linkTo == navigationPath.fire {
                HStack {
                    Text("Vehicle Fire")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color("VehicleFire3"))
                .foregroundStyle(.black)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
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

