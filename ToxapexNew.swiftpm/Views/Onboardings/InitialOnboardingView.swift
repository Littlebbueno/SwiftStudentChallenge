//
//  InitialOnboarding.swift
//  RoadHelper
//
//  Created by Marco Bueno on 23/02/26.
//

import SwiftUI

struct InitialOnboardingView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("initialOnboarding") var initialOnboarding: Bool = false
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        ZStack {
            if colorScheme == .light {
                Color.white
            }else {
                Color.black
            }
            LinearGradient(
                stops: [
                    .init(color: Color("OnboardingBlue").opacity(0.5), location: 0),
                    .init(color: .clear, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 90)
                        .foregroundStyle(Color.white)
                    Circle()
                        .frame(width: 80)
                        .foregroundStyle(.white)
                    Image("AppIconImage")
                        .resizable()
                        .frame(width: 120, height: 120)
                }
                VStack(spacing: 30) {
                    Text("RoadHelper")
                        .foregroundStyle(.primary)
                        .font(.title)
                        .fontWeight(.bold)
                    var attributedString: AttributedString {
                        var str = AttributedString("RoadHelper is designed to improve your trip. The app features step-by-step guides for road emergencies and an attention assistant to help you maintain focus while driving.")
                        if let range = str.range(of: "RoadHelper") {
                            str[range].font = .callout.bold()
                        }
                        return str
                    }
                    Text(attributedString)
                        .foregroundStyle(.primary)
                        .opacity(0.55)
                        .font(.callout)
//                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.ultraThinMaterial)
//                                .environment(\.colorScheme, .dark)
                        }
                    
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem {
                if initialOnboarding {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                    }
                    .tint(Color.primary)
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
        .ignoresSafeArea()
        .safeAreaInset(edge: .bottom) {
            Button{
                if initialOnboarding {
                    dismiss()
                }else {
                    initialOnboarding = true
                }
            }label:{
                Text(initialOnboarding ? "Close" : "Get Started")
                    .font(.headline)
                    .padding(.vertical, 8)
                    .containerRelativeFrame(.horizontal) { length, axis in
                        0.5 * length
                    }
            }
            .tint(Color("AlertColor2"))
            .clipShape(.capsule)
            .modifier(
                ConditionalButtonModifierProminent()
            )
            .padding()
            .dynamicTypeSize(...DynamicTypeSize.accessibility2)
            .padding(.bottom, 8)
            
        }
    }
}

#Preview {
    InitialOnboardingView()
}
