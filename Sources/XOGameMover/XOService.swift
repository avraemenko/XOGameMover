//
//  XOService.swift
//  XOMover
//
//  Created by Kateryna Avramenko on 20.11.22.
//

import Foundation

public enum Turn {
    case Empty
    case Cross
    case Nought
}

public enum TimeForGame: TimeInterval {
    case easy = 600
    case medium = 300
    case hard = 60
    case noTimer = 0
}

public enum TimeForMove: TimeInterval {
    case easy = 60
    case medium = 15
    case hard = 10
    case noTimer = 0
}

