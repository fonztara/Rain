import SwiftUI

@main
struct MyApp: App {
    @StateObject var vm: RageViewModel = RageViewModel()
    @StateObject var audio: AudioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .environmentObject(audio)
                .preferredColorScheme(.dark)
        }
    }
}
