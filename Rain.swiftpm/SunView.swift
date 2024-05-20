//
//  RainbowView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI
import SpriteKit

struct SunView: View {
    let scene = Sun()
    
    var body: some View {
        
        GeometryReader { _ in
            SpriteView(scene: self.scene, options: [.allowsTransparency])
                .opacity(0.6)
        }
    }
}

#Preview {
    SunView()
}


class Sun: SKScene {
    
    override func sceneDidLoad() {
        
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .resizeFill
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.backgroundColor = .clear
        
        guard let node = SKEmitterNode(fileNamed: "Sun.sks") else {
            print("Error loading rain emitter")
            return
        }
        node.name = "sun"
        addChild(node)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.childNode(withName: "sun")?.zRotation -= 0.001
    }
}
