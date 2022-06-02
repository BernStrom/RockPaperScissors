//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bern N on 5/31/22.
//

import SwiftUI

struct RockPaperScissorsEmoji: View {
    var source: String
    var caption: String
    
    var body: some View {
        VStack {
            Text(source)
                .font(.system(size: 55))
                .padding(10)
                .overlay(
                    Circle()
                        .stroke(Color(red: 0.1, green: 0.59, blue: 0.55), lineWidth: 1)
                )
            
            Text(caption)
                .font(.title3)
                .foregroundColor(Color(red: 0.1, green: 0.49, blue: 0.55))
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.secondary)
    }
}

struct ConditionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline.weight(.heavy))
            .foregroundStyle(.secondary)
    }
}

struct ConditionLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.weight(.light))
    }
}

struct PlayerProgress: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

extension View {
    func conditionTitleStyle() -> some View {
        modifier(ConditionTitle())
    }
}

extension View {
    func conditionLabelStyle() -> some View {
        modifier(ConditionLabel())
    }
}

extension View {
    func playerProgressColor() -> some View {
        modifier(PlayerProgress())
    }
}

struct ContentView: View {
    @State private var gameMoves = ["👊", "👋", "✌️"]
    @State private var playerMoves = ["👋", "✌️", "👊"]
    @State private var playerMoveNames = ["Paper", "Scissors", "Rock"]
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
            RadialGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.7, blue: 0.65, opacity: 0.9), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.45, blue: 0.26, opacity: 0.5), location: 1)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors")
                    .titleStyle()
                
                Spacer()
                
                VStack {
                    VStack(spacing: 15) {
                        Text("Select your move based on the conditions below")
                            .conditionTitleStyle()
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("Game Move:")
                                    .conditionLabelStyle()
                                
                                Text(gameMoves[appChoice])
                                    .font(.largeTitle)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("Win or Lose Round:")
                                    .conditionLabelStyle()
                                
                                if playerShouldWin {
                                    Text("Win")
                                        .font(.largeTitle.weight(.semibold))
                                        .foregroundColor(Color(red: 0.1, green: 0.69, blue: 0.55))
                                } else {
                                    Text("Lose")
                                        .font(.largeTitle.weight(.semibold))
                                        .foregroundColor(Color(red: 0.69, green: 0.1, blue: 0.25))
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack(spacing: 40) {
                        ForEach(0..<3) { moveNumber in
                            Button {
                                moveTapped(moveNumber)
                            } label: {
                                RockPaperScissorsEmoji(source: playerMoves[moveNumber], caption: playerMoveNames[moveNumber])
                            }
                        }
                    }
                    .padding(.vertical, 50)
                }
                
                Spacer()
                
                Text("Round \(numRounds) of 10")
                    .font(.headline)
                    .playerProgressColor()
                
                Spacer()
                
                Text("Score: \(playerScore)")
                    .font(.title.bold())
                    .playerProgressColor()
                
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
