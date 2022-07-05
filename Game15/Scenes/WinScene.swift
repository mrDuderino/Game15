//
//  WinScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 01.07.2022.
//

import SpriteKit

class WinScene: ParentScene {
    
    var currentScores: [Int]!
    
    override func didMove(to view: SKView) {
        gameSettings.loadScores()
        currentScores = gameSettings.currentHighscore
        
        setHeader(withName: "your score", size: CGSize(width: 280, height: 70))
        
        setSubHeader(withName: "moves",
                     color: .systemIndigo,
                     size: CGSize(width: 100, height: 40),
                     point: CGPoint(x: self.frame.midX - 60, y: self.frame.midY + 120))
        
        setSubHeader(withName: "timer",
                     color: .systemIndigo,
                     size: CGSize(width: 100, height: 40),
                     point: CGPoint(x: self.frame.midX + 60, y: self.frame.midY + 120))
        
        showCurrentScore()
        
        let titles = ["restart", "records", "menu"]
        for (index, title) in titles.enumerated() {
            let button = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 160, height: 60), fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 60 - CGFloat(90 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    fileprivate func showCurrentScore() {
        let scores = [currentScores[0].description, showTime(timer: currentScores[1])]
        for (index, value) in scores.enumerated() {
            let label = SKLabelNode(text: value)
            label.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1.0)
            label.fontName = "AmericanTypewriter-Bold"
            label.fontSize = 25
            label.name = "currentHighscore"
            label.position = CGPoint(x: self.frame.midX - 60 + CGFloat(120 * index), y: self.frame.midY + 30)
            addChild(label)
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
        } else if node.name == "records" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        } else if node.name == "menu" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let menuScene = MenuScene(size: self.size)
            menuScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(menuScene, transition: transition)
        }
    }
}
