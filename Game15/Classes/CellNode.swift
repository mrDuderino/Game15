//
//  CellNode.swift
//  Game15
//
//  Created by Vladimir Strepitov on 27.06.2022.
//

import SpriteKit

class CellNode: SKSpriteNode {
    
    var location: CGPoint = CGPoint(x: 0, y: 0)
    
    let label: SKLabelNode = {
        let l = SKLabelNode(text: "")
        l.fontColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        l.fontName = "AmericanTypewriter-Bold"
        l.fontSize = 30
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 2
        
        return l
    }()
    init(titled title: String?, backgroundColor: UIColor, size: CGSize, fontSize: CGFloat) {
        
        super.init(texture: nil, color: backgroundColor, size: size)
        if let title = title {
            label.text = title.uppercased()
            label.fontSize = fontSize
        }
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

