//
//  CloudsView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI
import SpriteKit

struct CloudsView: View {
    let scene = Clouds()
    
    var body: some View {
        GeometryReader { _ in
            SpriteView(scene: self.scene, options: [.allowsTransparency])
        }
    }
}

#Preview {
    CloudsView()
}


class Clouds: SKScene {
    
    override func sceneDidLoad() {
        
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .resizeFill
        
        self.anchorPoint = CGPoint(x: 1.5, y: 0.5)
        
        self.backgroundColor = .clear
        
        guard let node = SKEmitterNode(fileNamed: "Clouds.sks") else {
            print("Error loading clouds emitter")
            return
        }
        node.particlePositionRange.dx = 0
        node.particlePositionRange.dy = UIScreen.main.bounds.height * 2
        addChild(node)
       
    }
}
