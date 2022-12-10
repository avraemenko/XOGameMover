//
//  Logger.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 10.12.22.
//

import Foundation


public class Logger {
    
    var log: [LogEntity]
    private var activeLogPointer: Int
    
    public init() {
        self.log = []
        self.activeLogPointer = self.log.endIndex
    }
    
    func writeLog(_ entity: LogEntity) {
        if !log.isEmpty {
            activeLogPointer += 1
        }
        log.append(entity)
    }
    
    func getLog() -> [LogEntity] {
        log
    }
    
    
    func rollBack() -> LogEntity? {
        if (0...log.count - 1).contains(activeLogPointer - 1) {
            activeLogPointer -= 1
            
            return log[activeLogPointer]
        }
        return nil
    }
    
    func rollForward() -> LogEntity? {
        if (0...log.count - 1).contains(activeLogPointer + 1) {
            activeLogPointer += 1
            return log[activeLogPointer]
        }
        return nil
    }
    
    func getCurrentLayout() -> [Turn]? {
        log.isEmpty ? nil : log[activeLogPointer].move.stateOfTheBoard
    }
    
}

public struct LogEntity {
    
    public let move : Move
    
    public let currentPlayerTime: TimeInterval

    public let opponentPlayerTime: TimeInterval
    
    
}
