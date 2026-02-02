//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 29/12/25.
//

import SwiftUI
import AVFoundation


@available(iOS 26.0, *)
struct AttentionView: View {
    
    // Inicializamos os gerenciadores
    @State private var cameraManager = CameraManager()
    @State private var eyeTracker = EyeTracker()
    
    // Fala
    @State private var timer: Timer?
    let intervalo: TimeInterval = 3
    let synthesizer = AVSpeechSynthesizer()
    
    @State private var assistActive: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
//    @State private var previewCameraActive: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Camada de Fundo: Preview da Câmera
                // Se quiser ver o que a câmera vê, descomentar a linha abaixo:
//                if previewCameraActive {
//                    CameraPreview(session: cameraManager.captureSession)
//                        .ignoresSafeArea()
//                }
                Image("imageExample2")
                    .resizable()
                    .containerRelativeFrame(.horizontal) { length, axis in
                        length * 1
                    }
                    .clipped()
                    .ignoresSafeArea()
                    .opacity(colorScheme == .dark ? 0.7 : 1)
                
                LandmarksOverlay(points: eyeTracker.leftEyePoints, size: geo.size, color: .cyan)
                LandmarksOverlay(points: eyeTracker.rightEyePoints, size: geo.size, color: .yellow)
                
                
                VStack(spacing: 40) {
                    // Indicador Visual de Status
                    statusIndicator
                    
                    // Texto Informativo
                    informativePart
                    Spacer()
                    buttonPlayAssistant
                        .padding()
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
                    stopTimer()
                    cameraManager.captureSession.stopRunning()
                }
            }
        }
        .navigationTitle("Attention Assistant")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var informativePart: some View {
        VStack {
            Text(eyeTracker.eyesClosed ? "OLHOS FECHADOS" : "OLHOS ABERTOS")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(eyeTracker.eyesClosed ? .red : Color.accentColor)
            
            Text("Mantenha o dispositivo fixo no painel")
                .font(.caption)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("CinzaCards").opacity(1))
                
        )
    }
    var buttonPlayAssistant: some View {
        Button{
            self.assistActive.toggle()
        }label:{
            Text("Toggle Assistente")
                .padding(5)
                .foregroundStyle(Color.black)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .tint(.white)
        .buttonStyle(.borderedProminent)
    }
    
    var statusIndicator: some View {
        Circle()
            .fill(eyeTracker.eyesClosed ? Color.red : Color.accentColor)
            .frame(width: 120, height: 120)
            .overlay(
                Image(systemName: eyeTracker.eyesClosed ? "xmark.circle" : "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
            )
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
