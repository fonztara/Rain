//
//  RageViewModel.swift
//  Rain
//
//  Created by Alfonso Tarallo on 22/02/24.
//

import Foundation
import SwiftUI
import PencilKit

class RageViewModel: ObservableObject {
    
    @Published var archive: [RagePhase] = []
    
    @Published var isWriting: Bool = true
    
    @Published var hasFinished: Bool = false
    
    @Published var hasToStart: Bool = true
    
    @Published var answer: String = ""
    
    @Published var canvas: PKCanvasView = PKCanvasView()
    
    @Published var drawing: UIImage = UIImage(named: "blank")!
    
    
    var lastPhase: RagePhase? {
        if let last = archive.last {
            return last
        } else {
            return nil
        }
    }
    
    var actualPhase: RagePhase {
        guard let lastPhase = self.lastPhase?.phase else {
            return RagePhase(phase: .recognize, answer: "")
        }
        switch lastPhase {
        case .recognize:
            return RagePhase(phase: .accept, answer: "")
        case .accept:
            return RagePhase(phase: .investigate, answer: "")
        case .investigate:
            return RagePhase(phase: .nonIdentify, answer: "")
        case .nonIdentify:
            return RagePhase(phase: .recognize, answer: "")
        }
    }
    
    func submit(answer: String) {
        isWriting = false
        self.answer = answer
    }
    
    func save() {
        let phaseFinished = RagePhase(phase: actualPhase.phase, answer: self.answer, drawing: self.drawing)
        archive.append(phaseFinished)
        self.canvas = PKCanvasView()
    }
    
    func nextPhase() {
        isWriting = true
    }
    
    func convertDrawing() {
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        self.drawing = image
    }
    
}


