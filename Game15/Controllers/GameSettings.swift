//
//  GameSettings.swift
//  Game15
//
//  Created by Vladimir Strepitov on 29.06.2022.
//

import SpriteKit

class GameSettings: NSObject {

    let ud = UserDefaults.standard
    
    var highscoreMoves: [Int] = []
    var currentMove = 0
    let highscoreMovesKey = "moveHighscore"

    var highscoreTime: [Int] = []
    var currentTime = 0
    let highscoreTimeKey = "timeHighscore"
    
    var currentHighscore: [Int] = []
    let currentHighscoresKey = "currentHighscore"
    
    var isMusic = true
    var musicKey = "musicKey"
    
    var isSound = true
    var soundKey = "soundKey"
    
    override init() {
        super.init()
        loadGameSettings()
        loadScores()
    }
    
    func saveScores() {
        highscoreMoves.append(currentMove)
        highscoreMoves = Array(highscoreMoves.sorted{ $0 < $1 }.prefix(3))

        highscoreTime.append(currentTime)
        highscoreTime = Array(highscoreTime.sorted{ $0 < $1 }.prefix(3))
        
        currentHighscore = [currentMove, currentTime]

        ud.set(highscoreMoves, forKey: highscoreMovesKey)
        ud.set(highscoreTime, forKey: highscoreTimeKey)
        ud.set(currentHighscore, forKey: currentHighscoresKey)
        ud.synchronize()
    }

    func loadScores() {
        guard ud.value(forKey: highscoreMovesKey) != nil else { return }
        guard ud.value(forKey: highscoreTimeKey) != nil else { return }
        guard ud.value(forKey: currentHighscoresKey) != nil else { return }

        highscoreMoves = ud.array(forKey: highscoreMovesKey) as! [Int]
        highscoreTime = ud.array(forKey: highscoreTimeKey) as! [Int]
        currentHighscore = ud.array(forKey: currentHighscoresKey) as! [Int]
    }
    
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSettings() {
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else { return }
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }
}
