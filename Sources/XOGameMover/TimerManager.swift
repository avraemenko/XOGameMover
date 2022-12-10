//
//  TimerManager.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 09.12.22.
//

import Foundation


enum stopWatchMode {

    case running
    case stopped
    case paused

}

class TimerManager: ObservableObject {
    
    @Published var mode: stopWatchMode = .stopped
    @Published var secondsElapsed = 0.0
    
    var timer = Timer()
    
    func start(timeInterval : TimeInterval) {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in self.secondsElapsed = self.secondsElapsed + 0.1
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }

    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}
