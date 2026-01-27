//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Meezotech Mac on 16/01/2026.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {

    @Test("Reset player Scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws{
        var scoreboard = Scoreboard( players: [
            Player(name: "Elisha", score: 0, color: "Green"),
            Player(name: "Andre", score: 5, color: "Green"),
        ])
        scoreboard.resetScores(to: newValue)
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }
    @Test("Highest Score Wins")
    func highestScoreWins()
    {
        let scoreboard = Scoreboard( players: [
            Player(name: "Elisha", score: 0, color: "Green"),
            Player(name: "Andre", score: 5, color: "Green"),],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Andre", score: 5, color: "Green")])
    }
    @Test("Lowest Score wins")
    func lowestScoreWins(){
        let scoreboard = Scoreboard( players: [
            Player(name: "Elisha", score: 0, color: "Green"),
            Player(name: "Andre", score: 5, color: "Green"),],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Elisha", score: 0, color: "Green")])
    }
}
