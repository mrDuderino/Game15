//
//  MenuScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 01.07.2022.
//


import SpriteKit

class MenuScene: ParentScene {
    
    var movePlaces: [Int]!
    var timePlaces: [Int]!
    
    override func didMove(to view: SKView) {
        gameSettings.loadScores()
        movePlaces = gameSettings.highscoreMoves
        timePlaces = gameSettings.highscoreTime
        
        setHeader(withName: "Game 15", color: .systemIndigo, size: CGSize(width: 270, height: 70))

        
        let titles = ["play", "best"]
        for (index, title) in titles.enumerated() {
            let button = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 120, height: 70), fontSize: 30)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
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
        } else if node.name == "best" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }

    }

}

