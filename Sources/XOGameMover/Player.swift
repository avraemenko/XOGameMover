//
//  Player.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 10.12.22.
//

import Foundation

public class Player : Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    var symbol: Turn
    var time = TimeInterval()
    @Published var timer = TimerManager()
    var points = 0
    
    public init(symbol: Turn, time: TimeInterval, points: Int = 0) {
        self.symbol = symbol
        self.time = time
        self.points = points
    }
}
