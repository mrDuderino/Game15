//
//  PauseScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 01.07.2022.
//


import SpriteKit

class PauseScene: ParentScene {
    
    var movePlaces: [Int]!
    var timePlaces: [Int]!
    
    override func didMove(to view: SKView) {
        setHeader(withName: "pause", size: CGSize(width: 200, height: 70))

        let titles = ["resume", "menu", "options", "restart"]
        for (index, title) in titles.enumerated() {
            let button = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 170, height: 60), fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50 - CGFloat(80 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            sceneManager.gameScene = nil
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "menu" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let menuScene = MenuScene(size: self.size)
            menuScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(menuScene, transition: transition)
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        } else if node.name == "resume" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }

    }

}

