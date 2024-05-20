//
//  RainFallingView.swift
//
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI
import SpriteKit

struct RainFallingView: View {
    let scene = RainFalling()
    
    var body: some View {
        GeometryReader { _ in
            SpriteView(scene: self.scene, options: [.allowsTransparency])
        }
    }
}

#Preview {
    RainFallingView()
}


class RainFalling: SKScene {
    override func sceneDidLoad() {
        
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .resizeFill
        
        self.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        self.backgroundColor = .clear
        
        guard let node = SKEmitterNode(fileNamed: "RainFalling.sks") else {
            print("Error loading rain emitter")
            return
        }
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        addChild(node)
       
    }
}
