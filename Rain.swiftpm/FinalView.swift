//
//  FinalView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI

struct FinalView: View {
    @EnvironmentObject var vm: RageViewModel
    @EnvironmentObject var audio: AudioManager
    var lastCycle: [RagePhase] {
        let cycleCount = 0  // 0 if latest
        let lastIndex = vm.archive.count - (1 + (cycleCount * 4))
        return [vm.archive[lastIndex - 3], vm.archive[lastIndex - 2], vm.archive[lastIndex - 1], vm.archive[lastIndex]]
    }
    
    var body: some View {
        ZStack {
            finalView
            
            
            VStack {
                
                Spacer()
                
                
            }
            
        }
    }
    
    var finalView: some View {
        ZStack {
            WeatherView()
            ScrollView {
                VStack {
                    ForEach(lastCycle) { phase in
                        HStack(alignment: .center) {
                            Image(uiImage: phase.drawing ?? UIImage(named: "blank")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .padding()
                            Text(phase.answer)
                                .padding()
                                .padding(.trailing)
                                .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
                        }
                        .padding()
                        .padding(.horizontal)
                    }
                    
                    Button {
                        vm.nextPhase()
                        vm.hasFinished = false
                        vm.hasToStart = true
                        switch vm.actualPhase.phase {
                        case .recognize:
                            audio.setCurrentSound(url: "wind")
                        case .accept:
                            audio.setCurrentSound(url: "rain")
                        case .investigate:
                            audio.setCurrentSound(url: "nature")
                        case .nonIdentify:
                            audio.setCurrentSound(url: "music")
                        }
                        audio.setupPlayer()
                        audio.playAudio()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(height: 70)
                            HStack {
                                Text("YOU CAN DO IT")
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.title)
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.title2)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .padding(.vertical)
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.thickMaterial)
                        .opacity(0.4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
            }
        }
    }
    
}

#Preview {
    FinalView()
}
