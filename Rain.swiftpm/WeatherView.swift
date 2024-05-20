//
//  WeatherView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var vm: RageViewModel
    @EnvironmentObject var audio: AudioManager
    
    var body: some View {
        ZStack {
            switch vm.actualPhase.phase {
            case .recognize:
                CustomColor.cloudySky
                CloudsView()
            case .accept:
                CustomColor.rainySky
                RainFallingView()
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .opacity(0.3)
                CloudsView()
            case .investigate:
                CustomColor.sunnyishSky
                SunView()
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .opacity(0.3)
                CloudsView()
            case .nonIdentify:
                CustomColor.sunnySky
                SunView()
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .opacity(0.3)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WeatherView()
}
