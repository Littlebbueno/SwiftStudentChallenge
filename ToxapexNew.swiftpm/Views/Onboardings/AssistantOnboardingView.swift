//
//  AssistantOnboardingView.swift
//  Toxapex
//
//  Created by Marco Bueno on 12/02/26.
//

import SwiftUI

struct AssistantOnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tabIndex : Int = 0
    
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: self.$tabIndex) {
                    FirstOnboardingAssistantView()
                        .tag(0)
                    AcessibilityOnboardingAssistantView()
                        .tag(1)
                    DayModesOnboardingAssistantView()
                        .tag(2)
                    
                }
                .ignoresSafeArea(edges: .all)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                Button {
                    if tabIndex < 2 {
                        withAnimation {
                            tabIndex += 1
                        }
                    }
                    else {
                        dismiss()
                    }
                }label: {
                    Text(tabIndex < 2 ? "Next" : "Close")
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .containerRelativeFrame(.horizontal) { length, axis in
                            0.5 * length
                        }
                }
                .tint(Color("AccentColor2"))
                .buttonStyle(.glassProminent)
            }
            .navigationTitle("Attention Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button{
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
                }
            }
            .onDisappear {
                UserDefaults.standard.set(false, forKey: "firstOnboarding")
            }
            
        }
    }
}

#Preview {
    AssistantOnboardingView()
        .preferredColorScheme(.dark)
}

struct FirstOnboardingAssistantView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color("NoFaceDetected").opacity(0), location: 0),
                    .init(color: .clear, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                Image("imageAssistant")
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.vertical) { length, axis in
                        length * 0.40
                    }
                    .clipped()
                    .padding(.bottom)
                VStack (alignment: .leading, spacing: 6) {
                    Text("Hello! I'm your Attention Assistant")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("I use machine learning to monitor your focus and alert you when signs of sleepiness appear.")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("How to use?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    Text("Before you drive, mount your phone at eye level about 10 to 20 inches (25–50 cm) from your face, ensuring a good view of your eyes and high volume. Test the tracking by blinking to confirm the indicators respond, and verify the illumination.")
                        .font(.subheadline)
                    Text("Always complete this setup while safely parked.")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    
                }
                .padding(.horizontal)
                Spacer()
            }
            .dynamicTypeSize(...DynamicTypeSize.large)
        }
    }
}
struct AcessibilityOnboardingAssistantView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color("OpenEyes").opacity(0.4), location: 0),
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
                        .frame(width: 100)
                        .foregroundStyle(Color.white)
                    Circle()
                        .frame(width: 80)
                        .foregroundStyle(.white)
                    Image(systemName: "accessibility.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color("OpenEyes"))
                }
                Text("Accessibility Mode")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Mode that is designed for users with ocular prosthetics, a lazy eye (strabismus), or any condition where one eye does not move or close in sync with the other.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .opacity(0.6)
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}
struct DayModesOnboardingAssistantView: View {
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Image(systemName: "sun.max")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                Image(systemName: "moon.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.indigo)
            }
            Text("Day and Night Mode.")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

//VStack(alignment: .leading, spacing: 20) {
//    VStack (alignment: .leading, spacing: 6) {
//        Text("Hello! I'm your Attention Assistant.")
//            .font(.title)
//            .fontWeight(.bold)
//        Text("I use machine learning to monitor your focus while driving and will let you know if you start showing signs of sleepiness.")
//            .font(.subheadline)
//        //                                .foregroundStyle(Color.secondary)
//    }
//    VStack(alignment: .leading, spacing: 20) {
//        VStack(alignment:.leading, spacing: 8) {
//            HStack {
//                Text("Acessibility Mode")
//                    .fontWeight(.bold)
//                Image(systemName: "accessibility.fill")
//                    .foregroundStyle(.blue)
//            }
//            .font(.title3)
//            
//            Text("This mode is designed for users with ocular prosthetics, a lazy eye (strabismus), or any condition where one eye does not move or close in sync with the other.")
//                .font(.subheadline)
//        }
//        VStack(alignment: .leading, spacing: 14) {
//            HStack {
//                Text("Day and Night Mode")
//                    .fontWeight(.bold)
//                Image(systemName: "sun.max")
//                    .frame(width: 20)
//                    .foregroundStyle(.orange)
//                Image(systemName: "moon.fill")
//                    .frame(width: 20)
//                    .foregroundStyle(.indigo)
//            }
//            .font(.title3)
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Day Mode")
//                    .font(.headline)
//                Text("Optimized for daylight. It uses high-efficiency computer vision to preserve battery life.")
//                    .font(.subheadline)
//            }
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Night Mode")
//                    .font(.headline)
//                Text("Powered by infrared sensors, this mode outperforms Day Mode in low-light settings, but it still requires some ambient light to track facial geometry.")
//                    .font(.subheadline)
//            }
//        }
//    }
//    
//}
//.padding(.horizontal)


