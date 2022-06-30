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
    
    override init() {
        super.init()
        loadScores()
    }
    
    func saveScores() {
        highscoreMoves.append(currentMove)
        highscoreMoves = Array(highscoreMoves.sorted{ $0 < $1 }.prefix(3))

        highscoreTime.append(currentTime)
        highscoreTime = Array(highscoreTime.sorted{ $0 < $1 }.prefix(3))

        ud.set(highscoreMoves, forKey: highscoreMovesKey)
        ud.set(highscoreTime, forKey: highscoreTimeKey)
        ud.synchronize()
    }

    func loadScores() {
        guard ud.value(forKey: highscoreMovesKey) != nil else { return }
        guard ud.value(forKey: highscoreTimeKey) != nil else { return }

        highscoreMoves = ud.array(forKey: highscoreMovesKey) as! [Int]
        highscoreTime = ud.array(forKey: highscoreTimeKey) as! [Int]
    }
}
