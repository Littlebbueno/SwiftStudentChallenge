//
//  AudioPlayerAttention.swift
//  Toxapex
//
//  Created by Marco Bueno on 19/02/26.
//

import SwiftUI
import AVFoundation

@Observable
class AudioPlayerAttention {
    var player: AVAudioPlayer?
    let synthesizer = AVSpeechSynthesizer()

    
    init() {
        self.setupAudio()
    }
    
    func wakeUpSound() {

        player?.play()
        player?.numberOfLoops = -1
    }
    
    func speakToPause() {
        let mensagem = "Your eyes look tired — please pull over safely and take a short rest before continuing."
        let utterance = AVSpeechUtterance(string: mensagem)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.volume = 1.0
        synthesizer.speak(utterance)

        try? AVAudioSession.sharedInstance().setActive(true)
        print("Pergunta emitida: \(Date())")

    }
    
    func setupAudio() {
        guard let soundFile = NSDataAsset(name: "alarmSound") else{
            print("Could not read the file named 'beepSound'")
            return
        }
        do {
            try player = AVAudioPlayer(data: soundFile.data)
            
        }catch{
            print("ERROr TO INICITIALIZE THE AUDIO PLAYER")
        }
    }
}
