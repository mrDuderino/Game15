//
//  MenuScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 01.07.2022.
//


import SpriteKit

class MenuScene: ParentScene {
    
    override func didMove(to view: SKView) {
        setHeader(withName: "Game 15", size: CGSize(width: 200, height: 70))
        
        let titles = ["play", "options", "records"]
        for (index, title) in titles.enumerated() {
            let button = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 170, height: 60), fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50 - CGFloat(90 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "play" {
            sceneManager.gameScene = nil
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        } else if node.name == "records" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }

    }

}

