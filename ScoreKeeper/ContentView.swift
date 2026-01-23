//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Meezotech Mac on 12/01/2026.
//

import SwiftUI

struct ContentView: View {
    //    @State private var players : [String] = ["Ali", "Ahad", "Anas"]
    //    @State private var scores : [Int] = [0, 0, 0]
    
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
//    @State private var  players: [Player] = [
//        Player(name: "Anas", score: 5, color: "Blue"),
//        Player(name: "Ali", score: 7, color: "Yellow"),
//        Player(name: "Ahad", score: 6, color: "Red"),
//    ]
    
    var body: some View {
        ZStack{
            LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.1, green: 0.8, blue: 1.0),   // light cyan top-left
                            Color(red: 1.0, green: 0.5, blue: 0.2),   // orange mid
                            Color(red: 1.0, green: 0.0, blue: 0.5),   // pink lower
                            Color(red: 0.6, green: 0.0, blue: 1.0)    // violet bottom
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("Score Keeper")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                SettingsView(startingPoints: $startingPoints)
                
                Grid{
                    GridRow {
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Text("Score")
                            .padding()
                        Text("Color")
                    }
                    .font(.headline)
                    ForEach($scoreboard.players){
                        $player in
                        GridRow{
                            TextField("Name", text: $player.name)
                            Text("\(player.score)")
                            TextField("Color", text: $player.color)
                                .padding(.horizontal, 16 )
                            Stepper("\(player.score)", value: $player.score)
                                .labelsHidden()
                        }
                    }
                }
                .padding(.vertical)
                .fontWeight(.semibold)
                
                Button("Add players", systemImage: "plus") {
                    scoreboard.players.append(Player(name: "", score: 0, color: ""))
                }
                .foregroundStyle(.white)
                .bold()
                
                Spacer()
                
                switch scoreboard.state{
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreboard.state = .playing
                        scoreboard.resetScores(to: startingPoints)
                    }
                case .playing:
                    Button("End Game", systemImage:"stop.fill") {
                        scoreboard.state = .gameOver
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockwise"){
                        scoreboard.state = .setup
                    }
//                default:
//                    EmptyView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
