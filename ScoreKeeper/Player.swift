//
//  Player.swift
//  ScoreKeeper
//
//  Created by Meezotech Mac on 13/01/2026.
//

import Foundation

struct Player: Identifiable {
    
    let id = UUID()
    var name : String
    var score : Int
    var color : String
}

extension Player:Equatable {
    static func == (lhs: Player, rhs: Player)-> Bool {
        lhs.name == rhs.name && lhs.score == rhs.score
    }
}
