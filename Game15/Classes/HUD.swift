//
//  HUD.swift
//  Game15
//
//  Created by Vladimir Strepitov on 28.06.2022.
//

import SpriteKit

class HUD: SKNode {
    let titleMovesLabel = SKLabelNode(text: "MOVES")
    
    let movesBackground = SKSpriteNode(imageNamed: "moves")
    let movesLabel = SKLabelNode(text: "0")
    var moves: Int = 0 {
        didSet {
            movesLabel.text = moves.description
        }
    }
    
    let titleTimerLabel = SKLabelNode(text: "TIMER")
    let timerBackground = SKSpriteNode(imageNamed: "timer")
    let timerLabel = SKLabelNode(text: "0")
    var timer: Int = 0 {
        didSet {
            timerLabel.text = timer.description
        }
    }
    
    func configureUI(screenSize: CGSize) {
        // Score
        titleMovesLabel.position = CGPoint(x: 105,
                                           y: screenSize.height - 80)
        titleMovesLabel.fontName = "AmericanTypewriter-Bold"
        titleMovesLabel.fontSize = 20
        titleMovesLabel.zPosition = 10
        addChild(titleMovesLabel)
        
        movesBackground.position = CGPoint(x: 110,
                                           y: screenSize.height - movesBackground.size.height / 2 - 10)
        movesBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        movesBackground.zPosition = 9
        addChild(movesBackground)
        
        movesLabel.horizontalAlignmentMode = .center
        movesLabel.verticalAlignmentMode = .center
        movesLabel.position = CGPoint(x: -5, y: 8)
        movesLabel.zPosition = 10
        movesLabel.fontName = "AmericanTypewriter-Bold"
        movesLabel.fontSize = 20
        movesBackground.addChild(movesLabel)
        
        // Timer
        titleTimerLabel.position = CGPoint(x: 305,
                                           y: screenSize.height - 80)
        titleTimerLabel.fontName = "AmericanTypewriter-Bold"
        titleTimerLabel.fontSize = 20
        titleTimerLabel.zPosition = 10
        addChild(titleTimerLabel)
        
        timerBackground.position = CGPoint(x: 310 ,
                                           y: screenSize.height - timerBackground.size.height / 2 - 10)
        timerBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        timerBackground.zPosition = 9
        addChild(timerBackground)
        
        timerLabel.verticalAlignmentMode = .center
        timerLabel.horizontalAlignmentMode = .center
        timerLabel.position = CGPoint(x: -5, y: 8)
        timerLabel.zPosition = 10
        timerLabel.fontName = "AmericanTypewriter-Bold"
        timerLabel.fontSize = 20
        timerBackground.addChild(timerLabel)
    }
}
