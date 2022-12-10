//
//  XOMove.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 28.11.22.
//

import Foundation

class XOMover {
    
    private var gameLayout: [Move]
    private var activeLayoutPointer: Int
    
    init(gameLayout: [Move]? = nil, gameCache: [Move]? = nil) {
        self.gameLayout = gameLayout ?? []
        self.activeLayoutPointer = self.gameLayout.endIndex
    }
    
    func makeMove(_ move: Move) {
        if !gameLayout.isEmpty {
            activeLayoutPointer += 1
        }
        gameLayout.append(move)
    }
    
    func rollBack() -> Move? {
        if (0...gameLayout.count - 1).contains(activeLayoutPointer - 1) {
            activeLayoutPointer -= 1
            
            return gameLayout[activeLayoutPointer]
        }
        return nil
    }
    
    func rollForward() -> Move? {
        if (0...gameLayout.count - 1).contains(activeLayoutPointer + 1) {
            activeLayoutPointer += 1
            return gameLayout[activeLayoutPointer]
        }
        return nil
    }
    
    func getCurrentLayout() -> Move? {
        gameLayout.isEmpty ? nil : gameLayout[activeLayoutPointer]
    }
    
}




