//
//  AttentionARKitView.swift
//  RoadHelper
//
//  Created by Marco Bueno on 02/02/26.
//
import SwiftUI
import AVFoundation

struct AttentionARKitView: View {
    
    @State var eyeTracker : ARFaceManager
    @Binding var playing: Bool
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var closedFramesCounter: Int = 0
    @State private var isDrowsy: Bool = false
    let impact = UIImpactFeedbackGenerator(style: .medium)

    @State var audioPlayer: AudioPlayerAttention

    
    @State private var assistActive: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    @State private var previewCameraActive: Bool = false
    @State private var showAlertCamera: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .top) {
                    ARCameraView(session: eyeTracker.session)
                        .containerRelativeFrame(.horizontal){ lenght, axis in
                            lenght * 0.35
                        }
                        .containerRelativeFrame(.vertical){ lenght, axis in
                            lenght * 0.35
                            
                        }
                        .cornerRadius(20)
                        .opacity(previewCameraActive ? 0.6 : 0.0)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(previewCameraActive ? 1 : 0.0))
                        }
                    if assistActive {
                        Button{
                            self.previewCameraActive.toggle()
                        }label:{
                            Image(systemName: previewCameraActive == true ? "video.slash" : "video")
                                .foregroundStyle(Color("AccentColor"))
                                .frame(height: 20)
                        }
                        .padding()
                        .tint(Color.white)
                        .clipShape(.capsule)
                        .modifier(
                            ConditionalButtonModifierProminent()
                        )
                    }
                    ZStack {
                        circleAlert(number: "1")
                            .scaleEffect(closedFramesCounter >= 10 ? 1.0 : 0.5)
                            .opacity(closedFramesCounter >= 10 ? 1.0 : 0.0)
                        
                        circleAlert(number: "2")
                            .scaleEffect(closedFramesCounter >= 20 ? 1.0 : 0.5)
                            .opacity(closedFramesCounter >= 20 ? 1.0 : 0.0)
                    }
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: closedFramesCounter)
                    .offset(y: -40)
                }
                .padding(.bottom, 100)
                if self.assistActive {
                    ButtonClose(action: {
                        withAnimation {
                            self.assistActive = false
                            self.previewCameraActive = false
                            self.playing = false

                        }
                        self.isDrowsy = false
                        audioPlayer.player?.stop()
                        Task {
                            try? await Task.sleep(nanoseconds: 200_000_000)
                            self.eyeTracker.eyeStatus = .nofaceDetected
                        }
                    })
                        .padding(30)
                }else{
                    ButtonStart(action: {
                        if checkCameraPermission() {
                            withAnimation {
                                self.assistActive = true
                                self.previewCameraActive = true
                                self.playing = true
                            }
                            impact.impactOccurred()
                        }
                        else {
                            self.showAlertCamera = true
                        }
                    })
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .padding(.top, 8)
                }
            }
            .padding(.top, 20)
        }
        .onReceive(timer) { _ in
            guard assistActive else {
                if closedFramesCounter != 0 { closedFramesCounter = 0 }
                return
            }

            if eyeTracker.eyeStatus != .opened {
                if closedFramesCounter < 20 {
                    closedFramesCounter += 1
                }
            } else {
                closedFramesCounter = max(0, closedFramesCounter - 2)
            }

            if closedFramesCounter >= 20 && !isDrowsy {
                isDrowsy = true
                audioPlayer.wakeUpSound()
            } else if closedFramesCounter == 0 && isDrowsy {
                guard let player = audioPlayer.player else { return }
                if player.isPlaying {
                    audioPlayer.player?.stop()
                }
                isDrowsy = false
                audioPlayer.speakToPause()
            }
        }
        .alert("Camera Access Required", isPresented: $showAlertCamera) {
            Button("Open Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("To monitor your attention and keep you safe while driving, the assistant needs access to the camera.")
        }
        .onChange(of: self.assistActive) { _, attentionAssist in
            if attentionAssist {
                eyeTracker.start()
            } else {
                eyeTracker.stop()
            }
        }
        .onDisappear{
            if assistActive {
                self.assistActive = false
            }
        }
        .navigationTitle("Attention Assistant")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func checkCameraPermission() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return false
        case .denied, .restricted:
            return false
        @unknown default:
            return false
        }
    }
}
