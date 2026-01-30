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
    var totalScore = 10
    
    var winners: [Player]
    {
        guard state == .gameOver else {return [ ] }
        if let totalScore = Optional(totalScore), doesHighestScoreWin && totalScore > 0 {
            return players.filter{ player in player.score >= totalScore}
        }
        
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
    mutating func updateScore(for playerName: String, by points: Int) {
        if let index = players.firstIndex(where: { $0.name == playerName }) {
            players[index].score += points

            // If this player reached or passed the totalScore, the game ends
            if players[index].score >= totalScore {
                state = .gameOver
            }
        }
    }
}
