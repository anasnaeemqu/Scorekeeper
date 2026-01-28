//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Meezotech Mac on 14/01/2026.
//

import Foundation

struct Scoreboard{
    
    var players: [Player] = [
        Player(name: "Anas", score: 3, color: "Green"),
        Player(name: "Ali", score: 6, color: "Green"),
        Player(name: "Ahad", score: 8, color: "Green"),
        Player(name: "Hammad", score: 5, color: "Red")
    ]
    
    var state = GameState.setup
    var doesHighestScoreWin = true
    var totalScore = true
    
    var winners: [Player]
    {
        guard state == .gameOver else {return [ ] }
        
        var winningScore = 0
        if doesHighestScoreWin {
            
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        return players.filter { player in player.score == winningScore}
    }
    mutating func resetScores(to newValue: Int){
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
