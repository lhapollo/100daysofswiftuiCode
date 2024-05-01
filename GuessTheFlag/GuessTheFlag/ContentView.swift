//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lexi Han on 2024-04-17.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round = 0
    @State private var showingGameOver = false
    
    @State private var flagSpinAmt = [0.0, 0.0, 0.0]
    @State private var flagOpacities = [1.0,1.0,1.0]
    @State private var flagScale = [1.0, 1.0, 1.0]
    
    @State private var flagNum = -1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    struct FlagImage: View {
        var flag: String
        
        var body: some View {
            Image(flag)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button {
                            flagNum = number
                            withAnimation{
                                flagSpinAmt[number] += 360
                                
                                flagOpacities[(number+1)%3] = 0.25
                                flagOpacities[(number+2)%3] = 0.25
                                
                                flagScale[(number+1)%3] = 0.5
                                flagScale[(number+2)%3] = 0.5
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                        }
                        .rotation3DEffect(.degrees(flagSpinAmt[number]), axis: (x:0, y:1, z:0))
                        .opacity(flagOpacities[number])
                        .scaleEffect(flagScale[number])
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            
            .alert("Game over!", isPresented: $showingGameOver) {
                Button("Restart?", action: resetGame)
            } message: {
                Text("Your score is \(score)/8")
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showingScore = true}
        round += 1
        if (round == 8) {
            showingGameOver = true
        }
    }
    
    func askQuestion() {
        if round < 8 {
            countries.shuffle()
            flagOpacities = [1.0, 1.0, 1.0]
            flagScale = [1.0, 1.0, 1.0]
            flagNum = -1
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func resetGame() {
        round = 0
        score = 0
        flagOpacities = [1.0, 1.0, 1.0]
        flagScale = [1.0, 1.0, 1.0]
        showingGameOver = false
        askQuestion()
    }
    
    
}

#Preview {
    ContentView()
}
