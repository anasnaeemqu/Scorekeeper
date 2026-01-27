//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Meezotech Mac on 19/01/2026.
//

import SwiftUI

struct SettingsView: View {
    @Binding var doesHighestScoreWin: Bool
    @Binding var startingPoints: Int
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Game Rules")
                .font(.headline)
                .bold()
            Divider()
            Picker("Winning condition", selection: $doesHighestScoreWin){
                Text("Highest Score Wins")
                    .tag(true)
                Text("Lowest Score Wins")
                    .tag(false)
            }
            Picker("Starting Points", selection: $startingPoints){
                Text("0 Starting Point")
                    .tag(0)
                Text("10 Starting Point")
                    .tag(10)
                Text("20 Starting Point")
                    .tag(20)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

#Preview {
    @Previewable @State var doesHighestScoreWin = true
    @Previewable @State var startingPoints = 10
    SettingsView(doesHighestScoreWin: $doesHighestScoreWin, startingPoints: $startingPoints)
}
