//
//  Move.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 10.12.22.
//

import Foundation

public class Move {
    var stateOfTheBoard: [Turn]
    var player: Player
    var cell: Int
    
    var numberOfCells: Int {
        stateOfTheBoard.count
    }
    
    public init(player: Player, cell: Int, stateOfTheBoard: [Turn]) {
        self.player = player
        self.cell = cell
        self.stateOfTheBoard = stateOfTheBoard
    }
}
