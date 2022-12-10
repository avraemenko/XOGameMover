//
//  TicTacToe1.0.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 29.11.22.
//

import Foundation

public class TicTacToe1 {
    
    //computed properties
    
    public private(set) var board = [Turn]()
    
    public private(set) var gameLog: Logger
    
    public private(set) var timeForGame = TimeInterval()
    
    public private(set) var players: (Player, Player)
    
    public private(set) var currentPlayer : Player
    
    public private(set) var gameIsFinished : Bool
    
    
    //initializing the game
     public init(timeForGame: TimeForGame) {
        board = Array(repeating: .Empty, count: 9)
        gameLog = Logger()
        self.timeForGame = timeForGame.rawValue
        let cross = Player(symbol: .Cross, time: timeForGame.rawValue)
        let nought = Player(symbol: .Nought, time: timeForGame.rawValue)
        players = (cross,nought)
        currentPlayer = players.0
        self.gameIsFinished = false
    }
    
    //Get available possible positions
    var legalMoves: [Int] {
        board.indices.filter { board[$0] == .Empty }
    }
    
    //starting the game
    func startTheGame(){
        currentPlayer.timer.start(timeInterval: timeForGame)
    }
    
    //move
    func move(cell : Int, completionHandler : ((Player) -> Void)? = nil) {
        if !gameIsFinished {
            currentPlayer.timer.pause()
            board[cell] = currentPlayer.symbol
            let move = Move(player: currentPlayer, cell: cell, stateOfTheBoard: board)
            let entity = LogEntity(move: move, currentPlayerTime: currentPlayer.time, opponentPlayerTime: getOppositePlayer().time)
            gameLog.writeLog(entity)
            //currentPlayer.time -= timeInterval()
            changeThePlayer()
            let _ = checkTheWinner()
            checkForDraw()
            if let completionHandler = completionHandler {
                completionHandler(currentPlayer)
            }
        }
    }
    
    //resigning
    func resignAction(){
        players.0.time = self.timeForGame
        players.1.time = self.timeForGame
        switch currentPlayer {
    case players.0:
            players.1.points += 1
    case players.1:
            players.0.points += 1
    default:
        break
    }
    }
    
    //Reset Game
    func resetAction(){
        gameIsFinished = false
        players.0.time = self.timeForGame
        players.1.time = self.timeForGame
        players.0.timer.stop()
        players.1.timer.stop()
        gameLog.log.removeAll()
        board  = Array(repeating: .Empty, count: 9)
    }
    
    //game analysis
    func rollBack() -> LogEntity? {
        if gameIsFinished {
           return  gameLog.rollBack()
        }
        return nil
    }
    
    func rollForward() -> LogEntity? {
        if gameIsFinished{
            return gameLog.rollForward()
        }
        return nil
    }
    
    func getLog() -> [LogEntity] {
         gameLog.getLog()
    }

    
    private func getOppositePlayer() -> Player {
        var oppositePlayer = currentPlayer
        switch currentPlayer {
        case players.0:
            oppositePlayer = players.1
        case players.1:
            oppositePlayer =  players.0
        default:
            break
        }
        return oppositePlayer
    }
    
    
    //changing the player
    private func changeThePlayer(){
        switch currentPlayer {
        case players.0:
            currentPlayer = players.1
        case players.1:
            currentPlayer = players.0
        default:
            break
        }
        currentPlayer.timer.start(timeInterval: timeForGame)
    }
    
    //draw check
    private func checkForDraw() {
        if board.allSatisfy({ $0 != .Empty }) && checkTheWinner() == nil {
          gameIsFinished = true
        }
    }
    
    //get the winner
    private func checkTheWinner() -> Player? {
        if
        board[0] == board[1] && board[0] == board[2] && board[0] != .Cross || // row 0
        board[3] == board[4] && board[3] == board[5] && board[3] != .Cross || // row 1
        board[6] == board[7] && board[6] == board[8] && board[6] != .Cross || // row 2
        board[0] == board[3] && board[0] == board[6] && board[0] != .Cross || // col 0
        board[1] == board[4] && board[1] == board[7] && board[1] != .Cross || // col 1
        board[2] == board[5] && board[2] == board[8] && board[2] != .Cross || // col 2
        board[0] == board[4] && board[0] == board[8] && board[0] != .Cross || // diag 0
        board[2] == board[4] && board[2] == board[6] && board[2] != .Cross   // diag 1
        {
            players.0.points += 1
            gameIsFinished = true
            return players.0
        }
        else if
            board[0] == board[1] && board[0] == board[2] && board[0] != .Nought || // row 0
            board[3] == board[4] && board[3] == board[5] && board[3] != .Nought || // row 1
            board[6] == board[7] && board[6] == board[8] && board[6] != .Nought || // row 2
            board[0] == board[3] && board[0] == board[6] && board[0] != .Nought || // col 0
            board[1] == board[4] && board[1] == board[7] && board[1] != .Nought || // col 1
            board[2] == board[5] && board[2] == board[8] && board[2] != .Nought || // col 2
            board[0] == board[4] && board[0] == board[8] && board[0] != .Nought || // diag 0
            board[2] == board[4] && board[2] == board[6] && board[2] != .Nought    // diag 1
        {
            players.1.points += 1
            gameIsFinished = true
            return players.1
        }
        
        return nil
    }
    
    
}
