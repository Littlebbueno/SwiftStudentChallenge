//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 29/12/25.
//

import SwiftUI
import AVFoundation


struct AttentionVisionView: View {
    
    @State private var cameraManager = CameraManager()
    @State private var eyeTracker = EyeTracker()
    
    @State private var timer: Timer?
    let intervalo: TimeInterval = 3
    let synthesizer = AVSpeechSynthesizer()
    
    @State private var assistActive: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    @State private var previewCameraActive: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if previewCameraActive {
                    CameraPreview(session: cameraManager.captureSession)
                        .containerRelativeFrame(.horizontal){ lenght, axis in
                            lenght * 0.4
                        }
                        .containerRelativeFrame(.vertical){ lenght, axis in
                            lenght * 0.4
                        }
                        .cornerRadius(20)
                }
                
//                LandmarksOverlay(points: eyeTracker.leftEyePoints, size: geo.size, color: .cyan)
//                LandmarksOverlay(points: eyeTracker.rightEyePoints, size: geo.size, color: .yellow)
                
                
                VStack(spacing: 20) {
                    statusIndicator
                    VStack {
                        if assistActive {
                            Button{
                                self.previewCameraActive.toggle()
                            }label:{
                                Image(systemName: previewCameraActive == true ? "video.slash" : "video")
                                    .foregroundStyle(Color("AccentColor"))
                                    .frame(height: 20)
                            }
                            .tint(Color.white)
                            .buttonStyle(.glassProminent)
                        }
                        informativePart
                    }
                    .padding()
                    Spacer()
                    if self.assistActive {
                        buttonCloseAssistant
                            .padding()
                    }else{
                        buttonPlayAssistant
                            .padding()
                    }
                }
                .padding(.top, 50)
            }
            .onChange(of: eyeTracker.eyeStatus) { _, eyeStatus in
                if assistActive {
                    if eyeStatus != .opened {
                        startTimer()
                    }
                    else {
                        stopTimer()
                    }
                }
            }
            .onChange(of: self.assistActive) { _, attentionAssist in
                if attentionAssist {
                    cameraManager.start()
                } else {
                    stopTimer()
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
        }
        .navigationTitle("Attention Assistant")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var informativePart: some View {
        VStack {
            if eyeTracker.eyeStatus == .nofaceDetected {
                Text("NO FACE DETECTED")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("NoFaceDetected2"))
                
                Text("For best results, securely mount your phone and keep your face centered. Ensure there is adequate lighting for face detection.")
                    .font(.caption)
                    .fontWeight(.medium)
            }else {
                Text(eyeTracker.eyeStatus == .closed ? "EYES CLOSED" : "EYES OPEN")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(eyeTracker.eyeStatus == .closed ? Color("ClosedEyes2") : Color("OpenEyes2"))
                
                Text("Keep the device securely in place on the dashboard.")
                    .font(.caption)
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
    var buttonPlayAssistant: some View {
        Button{
            withAnimation {
                self.assistActive = true
                self.previewCameraActive = true
            }
        }label:{
            HStack {
                Image(systemName:"play.fill")
                    .foregroundStyle(.black)
                Text("Start Assistant")
                    .padding(5)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
            }
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
            }
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
            .foregroundColor(Color("SevereAccident"))
            .frame(maxWidth: .infinity)

        }
    }
    
    var statusIndicator: some View {
        if eyeTracker.eyeStatus == .nofaceDetected {
            Circle()
                .foregroundStyle(Color("NoFaceDetected").gradient)
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                )
        }else {
            Circle()
                .foregroundStyle((eyeTracker.eyeStatus == .closed ? Color.red : Color("OpenEyes")).gradient)
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: eyeTracker.eyeStatus == .closed ? "xmark.circle" : "checkmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                )
        }
    }
    
    func falarPergunta() {
        let mensagem = "Are you awake?"
        let utterance = AVSpeechUtterance(string: mensagem)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5 // Velocidade da fala

        synthesizer.speak(utterance)
        print("Pergunta emitida: \(Date())")
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: intervalo, repeats: true) { _ in
            Task {
                await falarPergunta()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        synthesizer.stopSpeaking(at: .immediate)
    }
}
