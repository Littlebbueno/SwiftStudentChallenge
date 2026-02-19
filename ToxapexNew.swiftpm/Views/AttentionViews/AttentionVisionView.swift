//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 29/12/25.
//

import SwiftUI
import AVFoundation


struct AttentionVisionView: View {
    
    @State private var cameraManager  = CameraManager()
    @State var eyeTracker : EyeTracker
    @Binding var playing: Bool

    // Timer variaveis
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var closedFramesCounter: Int = 0
    @State private var isDrowsy: Bool = false
    
    //
    @State var audioPlayer: AudioPlayerAttention
    
    @State private var assistActive: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    @State private var previewCameraActive: Bool = false
    @State private var showAlertCamera: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                Spacer()
                ZStack(alignment: .top) {
                    CameraPreview(session: cameraManager.captureSession)
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
                                .fill(Color.black.opacity(previewCameraActive ? 1 : 0))
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
                        .buttonStyle(.glassProminent)
                    }
                    ZStack {
                        circleAlert(number: "1")
                            .scaleEffect(closedFramesCounter >= 10 ? 1.0 : 0.5)
                            .opacity(closedFramesCounter >= 10 ? 1.0 : 0.0)
                        
                        circleAlert(number: "2")
                            .scaleEffect(closedFramesCounter >= 20 ? 1.0 : 0.5)
                            .opacity(closedFramesCounter >= 20 ? 1.0 : 0.0)
                        
                        circleAlert(number: "3")
                            .scaleEffect(closedFramesCounter >= 30 ? 1.0 : 0.5)
                            .opacity(closedFramesCounter >= 30 ? 1.0 : 0.0)
                    }
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: closedFramesCounter)
                    .offset(y: -40)
                }
                .padding(.bottom, 100)
                if self.assistActive {
                    buttonCloseAssistant
                        .padding(30)
                }else{
                    buttonPlayAssistant
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
                if closedFramesCounter < 35 {
                    closedFramesCounter += 1
                }
            } else {
                closedFramesCounter = max(0, closedFramesCounter - 2)
            }

            if closedFramesCounter >= 35 && !isDrowsy {
                isDrowsy = true
                audioPlayer.wakeUpSound()
            } else if closedFramesCounter == 0 && isDrowsy {
                isDrowsy = false
                audioPlayer.speakToPause()
            }
            if closedFramesCounter <= 15 && isDrowsy {
                guard let player = audioPlayer.player else { return }
                if player.isPlaying {
                    audioPlayer.player?.stop()
                }
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
            Text("To monitor your attention and keep you safe while driving, the assistant needs access to the camera. Please enable it in Settings.")
        }
        .onChange(of: self.assistActive) { _, attentionAssist in
            if attentionAssist {
                cameraManager.start()
            } else {
                cameraManager.captureSession.stopRunning()
            }
        }
        // Sempre que o frame da câmera mudar, o Vision processa
        .onChange(of: cameraManager.currentFrame) { _ , newFrame in
            if let frame = newFrame {
                eyeTracker.detectEyes(on: frame)
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
    
    var buttonPlayAssistant: some View {
        Button{
            if checkCameraPermission() {
                withAnimation {
                    self.assistActive = true
                    self.previewCameraActive = true
                    self.playing = true
                }
            }
            else {
                self.showAlertCamera = true
            }
        }label:{
            HStack {
                Image(systemName:"play.fill")
                    .foregroundStyle(.black)
                Text("Start Assistant")
                    .padding(6)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .frame(maxWidth: .infinity)

        }
        .tint(.white)
        .buttonStyle(.glassProminent)
    }
    
    var buttonCloseAssistant: some View {
        Button {
            withAnimation {
                self.assistActive = false
                self.previewCameraActive = false
                self.playing = false
            }
            self.isDrowsy = false
//            self.synthesizer.stopSpeaking(at: .immediate)
            audioPlayer.player?.stop()
            Task {
                try? await Task.sleep(nanoseconds: 200_000_000)
                self.eyeTracker.eyeStatus = .nofaceDetected
            }
        }label:{
            HStack {
                Image(systemName: "square.fill")
                Text("Close Assistant")
                    .font(.headline)
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .foregroundColor(Color("AlertColor"))
            .frame(maxWidth: .infinity)

        }
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

struct circleAlert: View {
    let number: String
    var body: some View {
        Circle()
            .foregroundStyle(Color("AlertColor2"))
            .frame(width: 50, height: 50)
            .overlay {
                Text(number)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
    }
}
