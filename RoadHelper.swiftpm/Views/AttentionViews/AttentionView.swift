//
//  AttentionView.swift
//  RoadHelper
//
//  Created by Marco Bueno on 02/02/26.
//
import SwiftUI
import AVFoundation

struct AttentionView: View {
    @State var eyeTracker = ARFaceManager()
    @State var eyeTrackerVision = EyeTracker()
    
    let cornerRadiusButtons: CGFloat = 24

    @Environment(\.colorScheme) var colorScheme

    // false = Vision, true = ARKit
    @AppStorage("assistantModel") var attentionMode: Bool = false
    
    @State private var showAcessibilitySheet: Bool = false
    @State private var showAssistantOnboarding: Bool = false
    @State private var showAlertChangeModel: Bool = false
    @State private var showAlertARNotSuported: Bool = false
    
    let impact = UIImpactFeedbackGenerator(style: .light)
    
    @State var playing: Bool = false
    @AppStorage("firstOnboarding") var firstOnboarding: Bool = true
    
    // false = off, true = on
    @AppStorage("acessibilityMode") var acessibilityActivated: Bool = false
    // false = left, true = right
    @AppStorage("acessibilityEye") var acessibilityEye: Bool = false
    
    @AppStorage("ARNotSupported") var arNotSupported: Bool = false
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var audioPlayer = AudioPlayerAttention()

    var eyeTrackerToCheck: eyeStatus {
        attentionMode ? eyeTracker.eyeStatus : eyeTrackerVision.eyeStatus
    }

    init() {
        setupAudioSession()
    }
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Image("imageBack1")
                .resizable()
                .containerRelativeFrame(.horizontal) { length, axis in
                    length * 1
                }
                .clipped()
                .ignoresSafeArea()
                .opacity(colorScheme == .dark ? 0.7 : 0.8)
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
            
            if attentionMode && !firstOnboarding {
                AttentionARKitView(eyeTracker: self.eyeTracker, playing: self.$playing, audioPlayer: audioPlayer)
            }else if !firstOnboarding{
                AttentionVisionView(eyeTracker: self.eyeTrackerVision, playing: self.$playing, audioPlayer: audioPlayer)
            }
            VStack() {
                Spacer()
                if self.playing == false {
                    HStack {
                        buttonAcessibility
                            .containerRelativeFrame(.horizontal) { length, axis in
                                length * 0.50
                            }
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
        .alert("The device does not support night mode.", isPresented: $showAlertARNotSuported) {
            Button("Dismiss", role: .cancel) { }
        } message: {
            
        }
        .alert("Mode Updated", isPresented: $showAlertChangeModel) {
            Button("Dismiss", role: .cancel) { }
        } message: {
            if self.attentionMode {
                Text("Switched to Night Mode, it uses a model optimized for low-light environments.")
            } else {
                Text("Switched to Day Mode, it uses a model optimized for daylight environments.")
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
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
                    try? await Task.sleep(nanoseconds: 0_500_000_000)
                    
                    self.showAssistantOnboarding = true
                }
            }
        }
        .onChange(of: self.showAcessibilitySheet) { older, _ in
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
                .tint(Color.primary)

            }
        }
        .toolbarVisibility(self.playing ? .hidden : .visible, for: .tabBar)
    }
    
    var informativePart: some View {
        VStack {
            if self.playing {
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
            else {
                Text("ASSISTANT OFF")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("AttentionOffColor2"))
                
                Text("To start a session, tap the white button below.")
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
                    .foregroundStyle(Color("CinzaCards").opacity(colorScheme == .light ? 0.4: 0.0))
            }
                
        )
    }
    
    var statusIndicator: some View {
        VStack {
            if self.playing {
                if eyeTrackerToCheck == .nofaceDetected {
                    Circle()
                        .foregroundStyle(Color("NoFaceDetected").gradient)
                        .frame(width: 115, height: 115)
                        .overlay(
                            Image(systemName: "questionmark.circle")
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
            else {
                Circle()
                    .foregroundStyle(Color("AttentionOffColor").gradient)
                    .frame(width: 115, height: 115)
                    .overlay(
                        Image(systemName: "face.dashed")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                    )
                
            }
        }
    }
    
    var buttonExtra: some View {
        Menu {
            Button {
                if self.attentionMode {
                    self.attentionMode = false
                    self.showAlertChangeModel = true
                    impact.impactOccurred()
                }
                
            } label: {
                Label("Day Mode", systemImage: "sun.max.fill")
            }
            Button {
                if self.arNotSupported {
                    self.showAlertARNotSuported = true
                }else {
                    if !self.attentionMode {
                        self.attentionMode = true
                        self.showAlertChangeModel = true
                        impact.impactOccurred()
                    }
                }
            } label: {
                Label("Night Mode", systemImage: "moon.fill")
            }
        } label:{
            Circle()
                .frame(width: 44)
                .overlay(Image(systemName: attentionMode ? "moon.fill" : "sun.max.fill").foregroundStyle(.white))
                .foregroundStyle(self.attentionMode ? Color("NightColor") : Color("DayColor"))
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
                RoundedRectangle(cornerRadius: cornerRadiusButtons)
                    .fill(.ultraThinMaterial)
                    .opacity(0.6)
                    .environment(\.colorScheme, .dark)
                RoundedRectangle(cornerRadius: cornerRadiusButtons)
                    .foregroundStyle(self.acessibilityActivated ? Color("AccessibilityColor3") : .clear)
                RoundedRectangle(cornerRadius: cornerRadiusButtons)
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
            print("Audio session setup failed: \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        AttentionView()
    }
}
