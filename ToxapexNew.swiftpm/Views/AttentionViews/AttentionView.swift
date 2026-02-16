//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//
import SwiftUI
import AVFoundation

struct AttentionView: View {
    @State var eyeTracker = ARFaceManager()
    @State var eyeTrackerVision = EyeTracker()

    @State var editedMode: Bool = false
    // false == Vision, true == ARKit
    @Environment(\.colorScheme) var colorScheme
    
    // false = Vision, true = ARKit
    @AppStorage("assistantModel") var attentionMode: Bool = false
    @State private var showAcessibilitySheet: Bool = false
    @State private var showAssistantOnboarding: Bool = false
    @State var playing: Bool = false
    @AppStorage("firstOnboarding") var firstOnboarding: Bool = true
    
    // false = off, true = on
    @AppStorage("acessibilityMode") var acessibilityActivated: Bool = false
    // false = left, true = right
    @AppStorage("acessibilityEye") var acessibilityEye: Bool = false
    
    @Environment(\.scenePhase) var scenePhase

    var eyeTrackerToCheck: eyeStatus {
        attentionMode ? eyeTracker.eyeStatus : eyeTrackerVision.eyeStatus
    }

    init() {
        setupAudioSession()
    }
    var body: some View {
        ZStack {
            Image("imageExample2")
                .resizable()
                .containerRelativeFrame(.horizontal) { length, axis in
                    length * 1
                }
                .clipped()
                .ignoresSafeArea()
                .opacity(colorScheme == .dark ? 0.8 : 1)
            LinearGradient(
                stops: [
                    .init(color: .black, location: 0),
                    .init(color: .clear, location: 0.4)
                ],
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            VStack(spacing: 16) {
                statusIndicator
                informativePart
                Spacer()
            }
            .padding(.top, 15)
            .padding(.horizontal)
            
            if attentionMode {
                AttentionARKitView(eyeTracker: self.eyeTracker, playing: self.$playing)
            }else{
                AttentionVisionView(eyeTracker: self.eyeTrackerVision, playing: self.$playing)
            }
            VStack {
                Spacer()
                if self.playing == false {
                    HStack {
                        buttonAcessibility
                        buttonExtra
                    }
                    .padding(.bottom, 80)
                    .padding(.horizontal)
                }
            }
            Color.black
                .ignoresSafeArea()
                .opacity(self.playing ? 0.4 : 0)
            
        }
        //para o celular não desligar durante a viagem por falta de interação.
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                UIApplication.shared.isIdleTimerDisabled = true
            } else {
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
        //
        .onAppear {
            if self.firstOnboarding {
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    
                    self.showAssistantOnboarding = true
                }
            }
        }
        .onChange(of: self.showAcessibilitySheet) { older, _ in
            print("deu certo 1")
            self.eyeTracker.reloadSettings()
            self.eyeTrackerVision.reloadSettings()
        }
        .sheet(isPresented: $showAcessibilitySheet){
            AcessiblitySheetView()
                .presentationCornerRadius(35)
        }
        .sheet(isPresented: $showAssistantOnboarding){
            AssistantOnboardingView()
                .presentationCornerRadius(35)
        }
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button{
                    self.showAssistantOnboarding = true
                }label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .toolbarVisibility(self.playing ? .hidden : .visible, for: .tabBar)
    }
    
    var informativePart: some View {
        VStack {
            
            if eyeTrackerToCheck == .nofaceDetected {
                Text("NO FACE DETECTED")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("NoFaceDetected2"))
                
                Text("For best results, securely mount your phone and keep your face centered. Ensure there is adequate lighting for face detection.")
                    .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                    .font(.caption)
                    .fontWeight(.medium)
            }else {
                Text(eyeTrackerToCheck == .closed ? "EYES CLOSED" : "EYES OPEN")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(eyeTrackerToCheck == .closed ? Color("ClosedEyes2") : Color("OpenEyes2"))
                
                Text("Keep the device securely in place on the dashboard.")
                    .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                    .font(.caption)
                    .fontWeight(.medium)

            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color("CinzaCards").opacity(colorScheme == .light ? 0.3: 0.0))
            }
                
        )
    }
    
    var statusIndicator: some View {
        if eyeTrackerToCheck == .nofaceDetected {
            Circle()
                .foregroundStyle(Color("NoFaceDetected").gradient)
                .frame(width: 115, height: 115)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                )
        }else {
            Circle()
                .foregroundStyle((eyeTrackerToCheck == .closed ? Color.red : Color("OpenEyes")).gradient)
                .frame(width: 115, height: 115)
                .overlay(
                    Image(systemName: eyeTrackerToCheck == .closed ? "xmark.circle" : "checkmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                )
        }
    }
    
    var buttonExtra: some View {
        Button {
            withAnimation {
                self.attentionMode.toggle()
            }
        }label:{
            HStack(spacing: 6) {
                Image(systemName: attentionMode ? "moon.fill" : "sun.max.fill")
                    .foregroundStyle(.white)
                Text(attentionMode ? "Night Mode" : "Day Mode")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(Color.white.opacity(0.6))
            }
            .padding(.horizontal, 8)
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
                    .opacity(0.3)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(self.attentionMode ? Color("Medical") : Color("VehicleFire2"))
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
            }
        }
    }
    var buttonAcessibility: some View {
        Button {
            showAcessibilitySheet = true
        }label:{
            HStack(spacing: 6) {
                Image(systemName: "accessibility.fill")
                    .foregroundStyle(.white)
                Text("Accessibility")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(Color.white.opacity(0.6))
            }
            .padding(.horizontal, 8)
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
                    .opacity(0.3)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(self.acessibilityActivated ? Color("OpenEyes") : .clear)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
            }
        }
    }
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .moviePlayback,
                options: [.duckOthers, .interruptSpokenAudioAndMixWithOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Erro ao configurar áudio: \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        AttentionView()
            .preferredColorScheme(.dark)
    }
}
