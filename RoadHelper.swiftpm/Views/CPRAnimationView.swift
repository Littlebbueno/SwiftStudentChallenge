//
//  CPRAnimationView.swift
//  RoadHelper
//
//  Created by Marco Bueno on 04/02/26.
//
import SwiftUI
import AVFAudio

struct CPRAnimationView: View {
    @State private var isExpanding = false
    @State private var counter = 0
    let bpmInterval = 0.545
    
    let timer = Timer.publish(every: 0.545, on: .main, in: .common).autoconnect()

    @State private var audioPlayer: AVAudioPlayer!

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
                        .easeOut(duration: bpmInterval)
                            .repeatForever(autoreverses: false),
                        value: isExpanding
                    )
                    .sensoryFeedback(.impact(weight: .heavy, intensity: 1000), trigger: counter)
            }
        }
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 100_000_000)
                setupAudio()
                audioPlayer.numberOfLoops = -1
                audioPlayer.play()
            }
        }
        .onReceive(timer) { _ in
            playPulse()
        }
    }
    
    func setupAudio() {
        guard let soundFile = NSDataAsset(name: "beepSound") else{
            print("Could not load the 'beepSound' asset")
            return
        }
        do {
            try audioPlayer = AVAudioPlayer(data: soundFile.data)
            
        }catch{
            print("Failed to initialize the audio player")
        }
    }

    func playPulse() {
        counter += 1
        isExpanding = true
    }
}

#Preview {
    CPRAnimationView()
}
