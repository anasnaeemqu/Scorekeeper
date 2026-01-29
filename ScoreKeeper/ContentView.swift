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
//            LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.1, green: 0.8, blue: 1.0),   // light cyan top-left
//                            Color(red: 1.0, green: 0.5, blue: 0.2),   // orange mid
//                            Color(red: 1.0, green: 0.0, blue: 0.5),   // pink lower
//                            Color(red: 0.6, green: 0.0, blue: 1.0)    // violet bottom
//                        ]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.00, green: 0.73, blue: 0.60), // peach top-left
                    Color(red: 1.00, green: 0.55, blue: 0.48), // coral
                    Color(red: 0.95, green: 0.45, blue: 0.65), // pink
                    Color(red: 0.78, green: 0.45, blue: 0.85)  // soft lavender bottom
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
                
                SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin,startingPoints: $startingPoints)
                    .disabled(scoreboard.state != .setup)
                
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
                            HStack{
                                if  scoreboard.winners.contains(player){
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow)
                                }
                                TextField("Name", text: $player.name)
                                    .disabled(scoreboard.state != .setup)
                            }
                            Text("\(player.score)")
                                .opacity(scoreboard.state == .setup ? 0 : 1.0)
                            TextField("Color", text: $player.color)
                                .padding(.horizontal, 16 )
                                .opacity(scoreboard.state == .setup ? 0 : 1.0)
                            Stepper("\(player.score)", value: $player.score)
                                .labelsHidden()
                                .opacity(scoreboard.state == .setup ? 0 : 1.0)
                        }
                    }
                }
                .padding(.vertical)
                .fontWeight(.semibold)
                
                Stepper("\(scoreboard.totalScore)", value: $scoreboard.totalScore, in: 10...500)
                    .opacity(scoreboard.state == .setup ? 1.0 : 0)
                
                Button("Add players", systemImage: "plus") {
                    scoreboard.players.append(Player(name: "", score: 0, color: ""))
                }
                .foregroundStyle(.white)
                .bold()
                .opacity(scoreboard.state == .setup ? 1.0 : 0)
                
                Spacer()
                HStack{
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
                    Spacer()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.black)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
