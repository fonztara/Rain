import SwiftUI
import AVFAudio

struct ContentView: View {
    @EnvironmentObject var vm: RageViewModel
    @EnvironmentObject var audio: AudioManager
    @State var currentTime: TimeInterval = 0.0
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            if vm.hasToStart {
                WeatherView()
                StartView()
            } else {
                if vm.hasFinished {
                    FinalView()
                } else {
                    WeatherView()
                    if vm.isWriting {
                        PromptView()
                    } else {
                        FeedbackView()
                    }
                }
            }
        }
        .onAppear {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .mixWithOthers])
            } catch {
                print("Error")
            }
            audio.setCurrentSound(url: "wind")
            audio.setupPlayer()
            audio.playAudio()
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            currentTime = audio.player?.currentTime ?? 0.0
            
            if (currentTime >= audio.totalTime - 0.2) {
                audio.player?.currentTime = 0.0
            }
        })
    }
}
