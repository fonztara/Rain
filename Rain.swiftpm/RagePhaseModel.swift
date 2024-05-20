//
//  RagePhaseModel.swift
//  Rain
//
//  Created by Alfonso Tarallo on 22/02/24.
//

import Foundation
import SwiftUI

let cycle: [RagePhase] = []

enum Phase: String, CaseIterable {
    case recognize = "Why do you feel angry? What happened?"
    case accept = "Explain your anger and get it all out!"
    case investigate = "Can you identify what triggers your rage? What is it trying to tell you? What other emotions are hiding behind it?"
    case nonIdentify = "Decide how you will channel your anger to be more constructive with yourself and other people from now on..."
}

struct RagePhase: Identifiable, Equatable {
    let id: UUID = UUID()
    let phase: Phase
    var description: String {
        switch self.phase {
        case .recognize:
            return "Recognizing your anger is the first step to avoid out of control outbursts in the future.\nAnger can blur your vision but you can manage it."
        case .accept:
            return "Accepting and embracing your anger helps you not repressing it.\nVenting is an important part and sometimes all we need is expressing our emotions."
        case .investigate:
            return "Investigating your anger you can understand it deeper.\nWhen we start to unfold our anger it reveals other emotions that we have probably been repressing."
        case .nonIdentify:
            return "Being able to process your emotions is important, so that we can avoid hurting ourselves and the people around us.\nThank you for doing your best!"
        }
    }
    
    
    
    var sketchPhrase: String {
        switch self.phase {
        case .recognize:
            return "Draw some clouds or sketch whatever you feel."
        case .accept:
            return "Draw some rain or sketch whatever you feel."
        case .investigate:
            return "Draw a rainbow or sketch whatever you feel."
        case .nonIdentify:
            return "Draw the sun or sketch whatever you feel."
        }
    }
    var answer: String
    var drawing: UIImage? = nil
}
