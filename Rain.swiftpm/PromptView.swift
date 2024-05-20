//
//  PromptView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI
import UIKit

struct PromptView: View {
    @EnvironmentObject var vm: RageViewModel
    @State var text: String = ""
    @State var img: UIImage = UIImage(named: "blank")!
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.thickMaterial)
                .opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            VStack {
                Text(vm.actualPhase.phase.rawValue)
                    .padding(.top)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.title)
                Text("Write whatever is in your mind and heart. Don't hold anything back.")
                    .multilineTextAlignment(.center)
                
                TextEditor(text: $text)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .scrollContentBackground(.hidden)
                    .background {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.thickMaterial)
                            .opacity(0.7)
                    }
                Text(vm.actualPhase.sketchPhrase)
                    .padding(.top)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.title2)
                Text("Don't worry! It doesn't have to be perfect.")
                
                DrawView()
                    .frame(maxWidth: UIScreen.main.bounds.width - 40)
                
                Spacer()
                Button(action: {
                    withAnimation() {
                        vm.convertDrawing()
                        vm.submit(answer: text)
                        text = ""
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
                                .bold()
                                .font(.title2)
                        }
                    }
                })
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    PromptView()
}
