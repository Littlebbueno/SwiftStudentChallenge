//
//  CPRAnimationView.swift
//  Toxapex
//
//  Created by Marco Bueno on 04/02/26.
//
import SwiftUI
import AVFoundation

struct CPRAnimationView: View {
    @State private var isExpanding = false
    @State private var counter = 0
    let bpmInterval = 60.0 / 110.0
    
    let timer = Timer.publish(every: 60.0 / 110.0, on: .main, in: .common).autoconnect()
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea(edges: .all)
            ZStack {
                Circle()
                    .containerRelativeFrame(.vertical) { length, axis in
                        length * 0.20
                    }
                    .foregroundStyle(.white)
                    .opacity(1)
                Circle()
                    .foregroundStyle(Color.white.opacity(isExpanding ? 0 : 1))
                    .containerRelativeFrame(.vertical) { length, axis in
                        length * 0.25
                    }
                    .scaleEffect(isExpanding ? 1.5 : 0.8)
                    .animation(
                        Animation.easeOut(duration: bpmInterval)
                            .repeatForever(autoreverses: false),
                        value: isExpanding
                    )
                    .onReceive(timer) { _ in
                        playPulse()
                    }
                    .sensoryFeedback(.impact, trigger: counter)
            }
        }
        .onAppear {
            setupAudio()
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
        }
    }
    
    func setupAudio() {
            let session = AVAudioSession.sharedInstance()
            try? session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try? session.setActive(true)
            if let soundURL = Bundle.main.url(forResource: "beepSound", withExtension: "wav") {
                audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.volume = 1.0
            }
        }

        func playPulse() {
//            if audioPlayer?.isPlaying == true {
//                audioPlayer?.stop()
//            }
//            audioPlayer?.currentTime = 0
//            audioPlayer?.play()
            
            counter += 1
            withAnimation(.easeInOut(duration: bpmInterval)) {
                isExpanding = true
            }
        }
}

#Preview {
    CPRAnimationView()
}
