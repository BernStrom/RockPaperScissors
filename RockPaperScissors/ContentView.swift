//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bern N on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameMoves = ["👊", "👋", "✌️"]
    @State private var winningMoves = ["👋", "✌️", "👊"]
    @State private var winningMoveNames = ["Paper", "Scissors", "Rock"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var numRounds = 1
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var showingScore = false
    @State private var endGame = false
    
    var body: some View {
        ZStack {
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
                                    .font(.largeTitle)
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
                    
                    HStack(spacing: 50) {
                        ForEach(0..<3) { moveNumber in
                            Button {
                                moveTapped(moveNumber)
                            } label: {
                                VStack {
                                    Text(winningMoves[moveNumber])
                                        .font(.system(size: 70))
                                    
                                    Text(winningMoveNames[moveNumber])
                                        .font(.title3)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 50)
                }
                
                Spacer()
                
                Text("Round \(numRounds) of 10")
                    .font(.headline)
                
                Spacer()
                
                Text("Score: \(playerScore)")
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("""
                 \(scoreMessage)
                 Your current score is \(playerScore) points.
                 """)
        }
        .alert(scoreTitle, isPresented: $endGame) {
            Button("Reset", action: reset)
        } message: {
            Text("You score a total of \(playerScore) points.")
        }
    }
    
    func moveTapped(_ number: Int) {
        if number == appChoice && playerShouldWin {
            scoreTitle = "Correct Move"
            scoreMessage = "You gained +10 points to your score!"
            playerScore += 10
        } else if number != appChoice && !playerShouldWin {
            scoreTitle = "Correct Move"
            scoreMessage = "You gained +10 points to your score!"
            playerScore += 10
        } else {
            scoreTitle = "Wrong Move"
            scoreMessage = "You lost -10 points off your score."
            
            if playerScore >= 10 {
                playerScore -= 10
            } else {
                playerScore = 0
            }
        }
        
        showingScore = true
        
        if numRounds == 10 {
            endGame = true
            scoreTitle = "Your Results"
        }
    }
    
    func nextRound() {
        if numRounds < 10 {
            numRounds += 1
            appChoice = Int.random(in: 0...2)
            playerShouldWin.toggle()
        }
    }
    
    func reset() {
        numRounds = 1
        playerScore = 0
        playerShouldWin = Bool.random()
        appChoice = Int.random(in: 0...2)
        showingScore = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
