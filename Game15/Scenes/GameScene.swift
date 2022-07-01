//
//  GameScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 27.06.2022.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    fileprivate var selectedNode = SKNode()
    fileprivate var сellMatrix = [[CellNode]]()
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var num = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"].shuffled()
    fileprivate lazy var matrix = [[num[0],num[1],num[2],num[3]],
                                   [num[4],num[5],num[6],num[7]],
                                   [num[8],num[9],num[10],num[11]],
                                   [num[12],num[13],num[14],""]].shuffled()
    fileprivate var winMatrix = [["1","2","3","4"],
                                 ["5","6","7","8"],
                                 ["9","10","11","12"],
                                 ["13","14","15",""]]
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .systemYellow
        configureMatrix(matrix: matrix, yOffset: 72)
        createHUD()
        startTimer()
    }
    
    fileprivate func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    fileprivate func startTimer() {
        let waitAction = SKAction.wait(forDuration: 1.0)
        let countAction = SKAction.run {
            self.hud.timer += 1
        }
        let sequence = SKAction.sequence([waitAction, countAction])
        run(SKAction.repeatForever(sequence))
    }
    
    fileprivate func configureMatrix(matrix: [[String]], yOffset: Int) {
        if self.сellMatrix.isEmpty == false {
            for row in self.сellMatrix {
                for col in row {
                    col.removeFromParent()
                }
            }
        }
        for (rowIndex, row) in matrix.enumerated() {
            var cellMatrixRow = [CellNode]()
            for (colIndex, title) in row.enumerated() {
                let button = CellNode(titled: title, backgroundColor: .darkGray, size: CGSize(width: 70, height: 70), fontSize: 30)
                switch colIndex {
                case 0:
                    let xOffset = CGFloat(72 + 72 / 2)
                    button.position = CGPoint(x: self.frame.midX - xOffset,
                                              y: self.frame.maxY - CGFloat(220 + yOffset * rowIndex))
                case 1:
                    let xOffset = CGFloat(72 / 2)
                    button.position = CGPoint(x: self.frame.midX - xOffset,
                                              y: self.frame.maxY - CGFloat(220 + yOffset * rowIndex))
                case 2:
                    let xOffset = CGFloat(72 / 2)
                    button.position = CGPoint(x: self.frame.midX + xOffset,
                                              y: self.frame.maxY - CGFloat(220 + yOffset * rowIndex))
                case 3:
                    let xOffset = CGFloat(72 + 72 / 2)
                    button.position = CGPoint(x: self.frame.midX + xOffset,
                                              y: self.frame.maxY - CGFloat(220 + yOffset * rowIndex))
                default:
                    break
                }
                
                button.name = title
                button.label.name = title
                button.location = button.position
                if button.name == "" {
                    button.color = .systemYellow
                }
                addChild(button)
                cellMatrixRow.append(button)
            }
            self.сellMatrix.append(cellMatrixRow)
        }
    }
    
    fileprivate func moveCell (cellIndex: (Int, Int), emptyIndex: (Int, Int)) {
        self.matrix[emptyIndex.0][emptyIndex.1] = matrix[cellIndex.0][cellIndex.1]
        self.matrix[cellIndex.0][cellIndex.1] = ""
        configureMatrix(matrix: matrix, yOffset: 72)
        hud.moves += 1
    }
    
    fileprivate func getEmptyCellIndex() -> (Int, Int)? {
        for (rowInd,row) in self.matrix.enumerated() {
            for (colInd,col) in row.enumerated() {
                if col == "" {
                    return (rowInd, colInd)
                }
            }
        }
        return nil
    }
    
    fileprivate func getCellindex(node: SKNode) -> (Int, Int)? {
        for (rowInd,row) in self.matrix.enumerated() {
            for (colInd,col) in row.enumerated() {
                if col == node.name && node.name != "" {
                    return (rowInd, colInd)
                }
            }
        }
        return nil
    }
    
    fileprivate func isEmptyCellAVailable(node: SKNode) -> Bool {
        guard let cell = getCellindex(node: node),
              let emptyCell = getEmptyCellIndex()
        else { return false }
        if cell.0 == emptyCell.0 && abs(cell.1 - emptyCell.1) == 1 {
            return true
        } else if cell.1 == emptyCell.1 && abs(cell.0 - emptyCell.0) == 1 {
            return true
        } else {
            return false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        guard node.name != nil else { return }
        selectedNode = node
        guard isEmptyCellAVailable(node: selectedNode) else {return}
        moveCell(cellIndex: getCellindex(node: selectedNode)!, emptyIndex: getEmptyCellIndex()!)
    }
    

    override func update(_ currentTime: TimeInterval) {
        //if hud.moves == 3 {
        if matrix == winMatrix {
            gameSettings.currentMove = hud.moves
            gameSettings.currentTime = hud.timer
            gameSettings.saveScores()
            let winScene = WinScene(size: self.size)
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            winScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(winScene, transition: transition)
        }
    }
}

