//
//  GameScene.swift
//  Game15
//
//  Created by Vladimir Strepitov on 27.06.2022.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    var selectedNode = CellNode(titled: nil, backgroundColor: .lightGray)
    var emptyIndex = (3, 3)
    var сellMatrix = [[CellNode]]()
    
    var num = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    fileprivate var matrix = [["1","2","3","4"],
                              ["5","6","7","8"],
                              ["9","10","11","12"],
                              ["13","14","15",""]]
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .systemCyan
        configureMatrix(matrix: matrix, yOffset: 75)
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
                let button = CellNode(titled: title, backgroundColor: .lightGray)
                switch colIndex {
                case 0:
                    let xOffset = CGFloat(75 + 75 / 2)
                    button.position = CGPoint(x: self.frame.midX - xOffset,
                                              y: self.frame.maxY - CGFloat(200 + yOffset * rowIndex))
                case 1:
                    let xOffset = CGFloat(75 / 2)
                    button.position = CGPoint(x: self.frame.midX - xOffset,
                                              y: self.frame.maxY - CGFloat(200 + yOffset * rowIndex))
                case 2:
                    let xOffset = CGFloat(75 / 2)
                    button.position = CGPoint(x: self.frame.midX + xOffset,
                                              y: self.frame.maxY - CGFloat(200 + yOffset * rowIndex))
                case 3:
                    let xOffset = CGFloat(75 + 75 / 2)
                    button.position = CGPoint(x: self.frame.midX + xOffset,
                                              y: self.frame.maxY - CGFloat(200 + yOffset * rowIndex))
                default:
                    break
                }
                
                button.name = title
                button.label.name = "label"
                button.location = button.position
                if button.name == "" {
                    button.color = .green
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
        configureMatrix(matrix: matrix, yOffset: 75)
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
    
    fileprivate func getCellindex(node: CellNode) -> (Int, Int)? {
        for (rowInd,row) in self.matrix.enumerated() {
            for (colInd,col) in row.enumerated() {
                if col == node.name && node.name != "" {
                    return (rowInd, colInd)
                }
            }
        }
        return nil
    }
    
    fileprivate func isEmptyCellAVailable(node: CellNode) -> Bool {
        let cell = getCellindex(node: node)
        let emptyCell = getEmptyCellIndex()
        
        if cell?.0 == emptyCell?.0 && abs(cell!.1 - emptyCell!.1) == 1 {
            return true
        } else if cell?.1 == emptyCell?.1 && abs(cell!.0 - emptyCell!.0) == 1 {
            return true
        } else {
            return false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        guard node.name != "label" else { return }
        guard node.name != nil else { return }
        selectedNode = node as! CellNode
        guard isEmptyCellAVailable(node: selectedNode) else {return}
        moveCell(cellIndex: getCellindex(node: selectedNode)!, emptyIndex: getEmptyCellIndex()!)
    }
}

