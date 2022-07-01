//
//  HUD.swift
//  Game15
//
//  Created by Vladimir Strepitov on 28.06.2022.
//

import SpriteKit

class HUD: SKNode {
    let titleMovesLabel = SKLabelNode(text: "MOVES")
    
    let movesBackground = SKSpriteNode(color: .systemIndigo, size: CGSize(width: 100, height: 40))
    let movesLabel = SKLabelNode(text: "0")
    var moves: Int = 0 {
        didSet {
            movesLabel.text = moves.description
        }
    }
    
    let titleTimerLabel = SKLabelNode(text: "TIMER")
    let timerBackground = SKSpriteNode(color: .systemIndigo, size: CGSize(width: 100, height: 40))
    let timerLabel = SKLabelNode(text: "0")
    var timer: Int = 0 {
        didSet {
            timerLabel.text = timer.description
        }
    }
    
    let menuButton = CellNode(titled: "pause", backgroundColor: .systemIndigo, size: CGSize(width: 160, height: 70), fontSize: 30)
    
    func configureUI(screenSize: CGSize) {
        // Score
        let xMoveCoord = screenSize.width / 2 + movesBackground.size.width / 2 - 143
        let yMoveCoord = screenSize.height - movesBackground.size.height / 2 - 90
        titleMovesLabel.position = CGPoint(x: xMoveCoord,
                                           y: yMoveCoord + 30)
        titleMovesLabel.fontName = "AmericanTypewriter-Bold"
        titleMovesLabel.fontColor = .darkGray
        titleMovesLabel.fontSize = 25
        titleMovesLabel.zPosition = 10
        addChild(titleMovesLabel)

        movesBackground.position = CGPoint(x: xMoveCoord,
                                           y: yMoveCoord)
        movesBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        movesBackground.zPosition = 8
        addChild(movesBackground)
        
 
        
        movesLabel.horizontalAlignmentMode = .center
        movesLabel.verticalAlignmentMode = .center
        movesLabel.zPosition = 10
        movesLabel.fontName = "AmericanTypewriter-Bold"
        movesLabel.fontSize = 20
        movesBackground.addChild(movesLabel)
        
        // Timer
        let xTimerCoord = screenSize.width / 2 - timerBackground.size.width / 2 + 143
        let yTimerCoord = screenSize.height - timerBackground.size.height / 2 - 90
        
        titleTimerLabel.position = CGPoint(x: xTimerCoord,
                                           y: yTimerCoord + 30)
        titleTimerLabel.fontName = "AmericanTypewriter-Bold"
        titleTimerLabel.fontColor = .darkGray
        titleTimerLabel.fontSize = 25
        titleTimerLabel.zPosition = 10
        addChild(titleTimerLabel)
        
        timerBackground.position = CGPoint(x: xTimerCoord,
                                           y: yTimerCoord)
        timerBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        timerBackground.zPosition = 8
        addChild(timerBackground)
        
        timerLabel.verticalAlignmentMode = .center
        timerLabel.horizontalAlignmentMode = .center
        timerLabel.zPosition = 10
        timerLabel.fontName = "AmericanTypewriter-Bold"
        timerLabel.fontSize = 20
        timerBackground.addChild(timerLabel)
        
        // menu
        menuButton.position = CGPoint(x: screenSize.width / 2, y: menuButton.size.height / 2 + 50)
        menuButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuButton.zPosition = 100
        menuButton.name = "pause"
        addChild(menuButton)
    }
}
