//
//  ParentScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 29.06.2022.
//

import SpriteKit

class ParentScene: SKScene {
    
    let gameSettings = GameSettings()
    let sceneManager = SceneManager.shared
    var backScene: SKScene?

    
    func setHeader(withName name: String?, size: CGSize) {
        let header = CellNode(titled: name, backgroundColor: SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0), size: size, fontSize: 30)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        self.addChild(header)
    }
    
    func setSubHeader(withName name: String?, color: UIColor, size: CGSize, point: CGPoint) {
        let subHeader = CellNode(titled: name, backgroundColor: .systemIndigo, size: size, fontSize: 20)
        subHeader.position = point
        subHeader.name = name
        subHeader.label.name = name
        self.addChild(subHeader)
    }
    
    func showTime(timer: Int) -> String {
        let minutes = timer / 60
        let seconds = timer % 60
        var time = ""
        if minutes < 10 && seconds < 10 {
            time = "0\(minutes):0\(seconds)"
        } else if minutes < 10 && seconds >= 10 {
            time = "0\(minutes):\(seconds)"
        } else if minutes >= 10 && seconds < 10 {
            time = "\(minutes):0\(seconds)"
        } else if minutes >= 10 && seconds >= 10 {
            time = "\(minutes):\(seconds)"
        }
        return time
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
