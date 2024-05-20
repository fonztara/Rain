//
//  StartView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 24/02/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var vm: RageViewModel
    @State var isRotating: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("rain")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.6)
                .padding()
                .padding(.top, 64)
                .rotationEffect(isRotating ? .degrees(3) : .degrees(2))
            Spacer()
            Button {
                vm.hasToStart = false
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity, maxHeight: 70)
                    HStack {
                        Text("START")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.title)
                        Image(systemName: "play.fill")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .bold()
                    }

                }
                .padding()
            }
        }
        .onAppear() {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                isRotating = true
            }
        }
    }
}

#Preview {
    StartView()
}
