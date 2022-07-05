//
//  BestScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 29.06.2022.
//

import SpriteKit

class BestScene: ParentScene {
    
    var movePlaces: [Int]!
    var timePlaces: [Int]!
    
    override func didMove(to view: SKView) {
        gameSettings.loadScores()
        movePlaces = gameSettings.highscoreMoves
        timePlaces = gameSettings.highscoreTime
        
        setHeader(withName: "best scores", size: CGSize(width: 270, height: 70))
        
        setSubHeader(withName: "moves", color: .systemIndigo, size: CGSize(width: 100, height: 40), point: CGPoint(x: self.frame.midX - 135 / 2, y: self.frame.midY + 85))
        
        setSubHeader(withName: "timer", color: .systemIndigo, size: CGSize(width: 100, height: 40), point: CGPoint(x: self.frame.midX + 135 / 2, y: self.frame.midY + 85))
        
        let titles = ["back"]
        for (index, title) in titles.enumerated() {
            let button = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 120, height: 60), fontSize: 25)
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200 + CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    fileprivate func showBestMoves() {
        for (index, value) in movePlaces.enumerated() {
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 25
            l.name = "movesHighscore"
            l.position = CGPoint(x: self.frame.midX - 135 / 2, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
        }
    }
    
    fileprivate func showBestTime() {
        for (index, value) in timePlaces.enumerated() {
            let time = showTime(timer: value)
            let l = SKLabelNode(text: time)
            l.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 25
            l.name = "timeHighscore"
            l.position = CGPoint(x: self.frame.midX + 135 / 2, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
        }
    }
    
    fileprivate func cleanBestScores() {
        for _ in 0...2 {
            if let timeNode = self.childNode(withName: "timeHighscore") {
                timeNode.removeFromParent()
            }
        }
        for _ in 0...2 {
            if let movesNode = self.childNode(withName: "movesHighscore") {
                movesNode.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        } else if node.name == "moves" {
            cleanBestScores()
            showBestMoves()
            
        } else if node.name == "timer" {
            cleanBestScores()
            showBestTime()
            
        }
    }

}
