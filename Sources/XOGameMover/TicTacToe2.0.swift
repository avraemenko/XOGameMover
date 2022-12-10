//
//  TicTacToe2.0.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 09.12.22.
//
import Foundation

public class TicTacToe2 {
    
    //computed properties
    public private(set) var board = [Turn]()
    public private(set) var gameLog: Logger
    public private(set) var timeForMove = TimeInterval()
    public private(set) var players: (Player, Player)
    public private(set) var currentPlayer : Player
    public private(set) var gameIsFinished : Bool
    public private(set) var timer = Timer()
    
   
    
    //Game Settings setup
    public init(timeForMove: TimeForMove, timer: Timer = Timer()) {
        self.board = Array(repeating: .Empty, count: 9)
        self.gameLog = Logger()
        self.timeForMove = timeForMove.rawValue
        let cross = Player(symbol: .Cross, time: timeForMove.rawValue)
        let nought = Player(symbol: .Nought, time: timeForMove.rawValue)
        self.players = (cross,nought)
        self.currentPlayer = players.0
        self.gameIsFinished = false
        self.timer = timer
    }
    
    //Get available possible positions
    var legalMoves: [Int] {
        board.indices.filter { board[$0] == .Empty }
    }
    
    //move
    func move(cell : Int, completionHandler : ((Player) -> Void)? = nil) {
        if !gameIsFinished {
            currentPlayer.timer.pause()
            board[cell] = currentPlayer.symbol
            let move = Move(player: currentPlayer, cell: cell, stateOfTheBoard: board)
            let entity = LogEntity(move: move, currentPlayerTime: currentPlayer.time, opponentPlayerTime: getOppositePlayer().time)
            gameLog.writeLog(entity)
            changeThePlayer()
            let _ = checkTheWinner()
            checkForDraw()
            if let completionHandler = completionHandler {
                completionHandler(currentPlayer)
            }
        }
    }
    
    //starting the game
    func startTheGame(){
      startTimerForMove()
    }
    
    //resigning
    func resignAction(){
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
    
    //private functions
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
        startTimerForMove()
    }
    
    //managing the timer for each move
    private func startTimerForMove(){
        timer = Timer.scheduledTimer(withTimeInterval: self.timeForMove, repeats: false) { timer in
            switch self.currentPlayer {
            case self.players.0:
                self.players.1.points += 1
            case self.players.1:
                self.players.0.points += 0
            default:
                break
            }
            self.gameIsFinished = true
        }
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
