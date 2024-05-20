//
//  FeedbackView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI

struct FeedbackView: View {
    @EnvironmentObject var vm: RageViewModel
    @EnvironmentObject var audio: AudioManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.thickMaterial)
                .opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            
            VStack {
                Spacer()
                Text("\(vm.actualPhase.description)")
                    .padding(.top)
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .font(.system(size: UIScreen.main.bounds.width / 16, weight: .light, design: .monospaced))
                Spacer()
                Button(action: {
                    withAnimation() {
                        if vm.actualPhase.phase == .nonIdentify {
                            vm.save()
                            vm.hasFinished = true
                        } else {
                            vm.save()
                            vm.nextPhase()
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
                        }
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(maxWidth: .infinity, maxHeight: 70)
                        HStack {
                            Text("NEXT")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title)
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .bold()
                        }
                    }
                })
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    FeedbackView()
}
