//
//  ContentView.swift
//  RPSBrainTrain
//
//  Created by Lexi Han on 2024-04-22.
//

import SwiftUI

struct ContentView: View {
    @State private var choices = ["🪨", "📄", "✂️"]
    @State private var cpuChoice = Int.random(in: 0...2)
    
    @State private var aimToWin = true
    
    @State private var score = 0
    @State private var round = 1
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    
    @State private var scoreAlertTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("RPS Brain Train")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("CPU Picks:")
                Text(choices[cpuChoice])
                Text("Pick a choice so you...")
                Text(aimToWin ? "WIN" : "LOSE")
                HStack {
                    ForEach(0..<3) { option in
                        Button {
                            userPick(option)
                        } label: {
                            Text(choices[option])
                        }
                    }
                }
                VStack{
                    Text("Score: \(score)")
                    Text("Round: \(round)/10")
                }
            }
            .alert(scoreAlertTitle, isPresented: $showingScore){
                Button("Continue", action: newRound)
            } message: {
                Text("Your score is : \(score)")
            }
            
            .alert("Game Over!", isPresented: $showingGameOver){
                Button("Restart", action: resetGame)
            } message: {
                Text("Your final score is: \(score)")
            }
        }
    }
    
    func userPick(_ number: Int){
        if cpuChoice == 0 {
            if number == 1 {
                if aimToWin {score += 1}
                scoreAlertTitle = (aimToWin ? "Correct!" : "Incorrect")
            } else if number == 2 {
                if !aimToWin {score += 1}
                scoreAlertTitle = (!aimToWin ? "Correct!" : "Incorrect")
            } else {
                scoreAlertTitle = "You tied..."
            }
        } else if cpuChoice == 1 {
            if number == 2 {
                if aimToWin {score += 1}
                scoreAlertTitle = (aimToWin ? "Correct!" : "Incorrect")
            } else if number == 0 {
                if !aimToWin {score += 1}
                scoreAlertTitle = (!aimToWin ? "Correct!" : "Incorrect")
            } else {
                scoreAlertTitle = "You tied..."
            }
        } else if cpuChoice == 2 {
            if number == 0 {
                if aimToWin {score += 1}
                scoreAlertTitle = (aimToWin ? "Correct!" : "Incorrect")
            } else if number == 1 {
                if !aimToWin {score += 1}
                scoreAlertTitle = (!aimToWin ? "Correct!" : "Incorrect")
            } else {
                scoreAlertTitle = "You tied..."
            }
        }
        showingScore = true
        if round == 10 {
           showingGameOver = true
        }
    }
    
    func newRound() {
        if round < 10 {
            round += 1
            aimToWin.toggle()
            cpuChoice = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        round = 0
        score = 0
        showingGameOver = false
        newRound()
    }
}

#Preview {
    ContentView()
}
