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
    
//    @State private var previewCameraActive: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
//                if previewCameraActive {
//                    CameraPreview(session: cameraManager.captureSession)
//                        .ignoresSafeArea()
//                }
                
                LandmarksOverlay(points: eyeTracker.leftEyePoints, size: geo.size, color: .cyan)
                LandmarksOverlay(points: eyeTracker.rightEyePoints, size: geo.size, color: .yellow)
                
                
                VStack(spacing: 40) {
                    statusIndicator
                    informativePart
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
            .onChange(of: eyeTracker.eyesClosed) { _, isClosed in
                if isClosed {
                    startTimer()
                } else {
                    stopTimer()
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
            if eyeTracker.noFaceDetected {
                Text("NO FACE DETECTED")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("DarkBrown"))
                
                Text("For best results, securely mount your phone and keep your face centered. Ensure there is adequate lighting for face detection.")
                    .font(.caption)
            }else {
                Text(eyeTracker.eyesClosed ? "EYES CLOSED" : "EYES OPEN")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(eyeTracker.eyesClosed ? .red : Color("DarkGreen"))
                
                Text("Keep the device securely in place on the dashboard.")
                    .font(.caption)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("CinzaCards").opacity(1))
                
        )
    }
    var buttonPlayAssistant: some View {
        Button{
            withAnimation {
                self.assistActive = true
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
            }
            Task {
                try? await Task.sleep(nanoseconds: 200_000_000)
                self.eyeTracker.noFaceDetected = true
            }
        }label:{
            HStack {
                Image(systemName: "square.fill")
                Text("Close Assistant")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)

        }
    }
    
    var statusIndicator: some View {
        if eyeTracker.noFaceDetected {
            Circle()
                .foregroundStyle(Color("DarkBrown").gradient)
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                )
        }else {
            Circle()
                .foregroundStyle((eyeTracker.eyesClosed ? Color.red : Color("DarkGreen")).gradient)
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: eyeTracker.eyesClosed ? "xmark.circle" : "checkmark.circle")
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
