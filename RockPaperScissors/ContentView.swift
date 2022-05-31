//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bern N on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameMoves = ["👊", "👋", "✌️"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var numQuestions = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack(spacing: 15) {
                    Text("Select your move based on the conditions below")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text("Game Move:")
                                .font(.title3.weight(.light))
                            
                            Text(gameMoves[appChoice])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Win or Lose Round:")
                                .font(.title3.weight(.light))
                            
                            if playerShouldWin {
                                Text("Win")
                                    .font(.largeTitle.weight(.semibold))
                            } else {
                                Text("Lose")
                                    .font(.largeTitle.weight(.semibold))
                            }
                        }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
            Spacer()
            
            Text("Question \(numQuestions) of 10")
                .font(.headline)
            
            Spacer()
            
            Text("Score: \(playerScore)")
                .font(.title.bold())
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
