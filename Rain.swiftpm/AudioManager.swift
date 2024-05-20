//
//  AudioManager.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//
//  SOUNDS
//  Wind - Sound Effect by Ghostie Ghost from Pixabay
//   https://pixabay.com/users/shut_up_ghost-32917765/
//  Rain - Sound Effect by Mikhail from Pixabay
//   https://pixabay.com/users/soundsforyou-4861230/
//  Nature - Sound Effect from Pixabay
//   https://pixabay.com/users/pixabay-1/
//  Music - Sound Effect by Samuel F. Johanns from Pixabay
//   https://pixabay.com/users/samuelfrancisjohnson-1207793/

import Foundation
import AVFAudio

class AudioManager: ObservableObject {
    @Published var totalTime: TimeInterval = 0.0
    
    @Published var currentSound: String? = nil
    
    @Published var player: AVAudioPlayer? = AVAudioPlayer()
    
    @Published var isPlaying: Bool = false
    
    
    
    init(totalTime: TimeInterval = 0.0, currentSound: String? = nil, audioPlayer: AVAudioPlayer? = AVAudioPlayer(), isPlaying: Bool = false) {
        self.totalTime = totalTime
        self.currentSound = currentSound
        self.player = audioPlayer
        self.isPlaying = isPlaying
    }
    
    
    
    //MARK: FUNCTIONS
    
    func setCurrentSound(url: String) {
        self.currentSound = url
    }
    
    func setupPlayer() {
        if( self.currentSound == nil ) {
            self.currentSound = "wind"
        }
        
        let url = Bundle.main.url(forResource: self.currentSound, withExtension: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: url!)
        self.player?.prepareToPlay()
        self.totalTime = self.player?.duration ?? 0.0
    }
    
    func playAudio() {
        if( self.currentSound == nil ) {
            self.currentSound = "wind"
        }
        self.isPlaying = true
        self.player?.play()
    }
    
    func setVolume(volume: Float) {
        player?.setVolume(volume, fadeDuration: 1.0)
    }
    
    func pausePlayer() {
        self.isPlaying = false
        
        if( self.currentSound == nil ) {
        } else {
            self.player?.stop()
        }
    }
    
}
