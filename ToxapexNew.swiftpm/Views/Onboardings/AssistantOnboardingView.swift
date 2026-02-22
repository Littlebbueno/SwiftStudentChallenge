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
    @Environment(\.colorScheme) var colorScheme

    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if tabIndex == 1 {
                    LinearGradient(
                        stops: [
                            .init(color: Color("OpenEyes").opacity(0.4), location: 0),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
                else if tabIndex == 2 {
                    LinearGradient(
                        stops: [
                            .init(color: Color("DayColor").opacity(0.4), location: 0),
                            .init(color: Color("NightColor").opacity(colorScheme == .dark ? 0.4 : 0.3), location: 0.3),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
                VStack {
                    TabView(selection: self.$tabIndex) {
                        FirstOnboardingAssistantView()
//                            .ignoresSafeArea(edges: .all)
                            .tag(0)
                        AcessibilityOnboardingAssistantView()
                        //                        .ignoresSafeArea(edges: .all)
                        
                            .tag(1)
                        DayModesOnboardingAssistantView()
                            .tag(2)
                        
                    }
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
                    .padding(.bottom)
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
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}

#Preview {
    AssistantOnboardingView()
        .preferredColorScheme(.dark)
}

struct FirstOnboardingAssistantView: View {
    @Environment(\.colorScheme) var colorScheme

    
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
                        length * 0.35
                    }
                    .clipped()
                    .padding(.bottom, 8)
                VStack (alignment: .leading, spacing: 6) {
                    Text("Hello!")
                        .font(.title)
                        .fontWeight(.bold)
                    var attributedString: AttributedString {
                        var str = AttributedString("I'm your Attention Assistant. I use machine learning to monitor your focus and alert you when signs of sleepiness appear.")
                        if let range = str.range(of: "Attention Assistant") {
                            str[range].font = .subheadline.bold()
                        }
                        return str
                    }
                    Text(attributedString)
                        .font(.subheadline)
//                        .fontWeight(.semibold)
                    Text("How to use?")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    Text("Before you drive, mount your phone with a clear view of your face, at a distance of 12 to 28 inches (30–70 cm), ensuring a good view of your eyes and high volume. Test the tracking by blinking to confirm the indicators respond.")
                        .font(.subheadline)
                    
                    
                }
                .padding(.horizontal)
                Spacer()
            }
            .dynamicTypeSize(...DynamicTypeSize.large)
        }
    }
}
struct AcessibilityOnboardingAssistantView: View {
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 90)
                        .foregroundStyle(Color.white)
                    Circle()
                        .frame(width: 80)
                        .foregroundStyle(.white)
                    Image(systemName: "accessibility.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color("OpenEyes"))
                }
                VStack(spacing: 30) {
                    Text("Accessibility Mode")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Mode that is designed for users with ocular prosthetics, amblyopia, or any condition where one eye does not move or close in sync with the other.")
                        .font(.callout)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .opacity(0.6)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(Color(.secondarySystemGroupedBackground))
                                .opacity(0.7)

            //                    .environment(\.colorScheme, .dark)
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke((colorScheme == .light ? Color.black : Color.white).opacity(0.3), lineWidth: 0.5)
                        }
                    
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}
struct DayModesOnboardingAssistantView: View {
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 90)
                            .foregroundStyle(Color.white)
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color("DayColor"))
                    }
                    ZStack {
                        Circle()
                            .frame(width: 90)
                            .foregroundStyle(Color.white)
                        Image(systemName: "moon.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color("NightColor"))
                    }
                }
                Text("Day & Night Mode")
                    .font(.title)
                    .fontWeight(.bold)
                VStack(spacing: 10) {
                    Text("Day Mode: Optimized for daylight.")
                        .font(.callout)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .opacity(0.6)
//                        .foregroundStyle(Color.secondary)
                    Text("Night Mode: Powered by infrared sensors, this mode outperforms Day Mode in low-light, but it still requires some ambient light.")
                        .font(.callout)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .opacity(0.6)
//                        .foregroundStyle(Color.secondary)

                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(.secondarySystemGroupedBackground))
                        .opacity(0.7)
    //                    .environment(\.colorScheme, .dark)
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke((colorScheme == .light ? Color.black : Color.white).opacity(0.3), lineWidth: 0.5)
                }
                Spacer()
                Spacer()
            }
            .padding()
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


