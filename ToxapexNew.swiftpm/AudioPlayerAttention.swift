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
//        AudioServicesPlaySystemSound(1005)
//        let mensagem = "Are you awake?"
//        let utterance = AVSpeechUtterance(string: mensagem)
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        utterance.rate = 0.5 // Velocidade da fala
//        utterance.volume = 1.0
//
//        synthesizer.speak(utterance)
//
//        try? AVAudioSession.sharedInstance().setActive(true)
        player?.play()
        player?.numberOfLoops = -1
//        print("Pergunta emitida: \(Date())")
    }
    
    func speakToPause() {
        let mensagem = "Pare e descanse um pouco"
        let utterance = AVSpeechUtterance(string: mensagem)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.5 // Velocidade da fala
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
