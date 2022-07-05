//
//  OptionsScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 02.07.2022.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    var isMusic: Bool!
    var isSound: Bool!
    
    override func didMove(to view: SKView) {
        
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        setHeader(withName: "options", size: CGSize(width: 270, height: 70))

        let backgroundNameForMusic = isMusic ? "music" : "nomusic"
        let music = CellNode(titled: nil, backgroundName: backgroundNameForMusic)
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        music.name = "music"
        music.label.isHidden = true
        addChild(music)
        
        let backgroundNameForSound = isSound ? "sound" : "nosound"
        let sound = CellNode(titled: nil, backgroundName: backgroundNameForSound)
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        sound.name = "sound"
        sound.label.isHidden = true
        addChild(sound)
        
        let titles = ["back"]
        for title in titles {
            let back = CellNode(titled: title, backgroundColor: .systemIndigo, size: CGSize(width: 120, height: 60), fontSize: 25)
            back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
            back.name = "back"
            back.label.name = "back"
            addChild(back)
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
        
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
        } else if node.name == "back" {
            gameSettings.isMusic = isMusic
            gameSettings.isSound = isSound
            gameSettings.saveGameSettings()
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
    
    func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
