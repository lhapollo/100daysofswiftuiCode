//
//  ContentView.swift
//  WordScramble
//
//  Created by Lexi Han on 2024-04-26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Score") {
                    Text("\(score.formatted())")
                }
                
                Section ("Words used"){
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {} message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Game") {
                    startGame()
                }
            }
        }
    }
    
    func startGame() {
        rootWord = ""
        newWord = ""
        usedWords = [String]()
        score = 0
        
        //find URL of start.txt in bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //load start.txt into string
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                //get all words put into array, split by newspace
                let allWords = startWords.components(separatedBy: "\n")
                
                //pick a random word, or use sensible default, "silkworm"
                rootWord = allWords.randomElement() ?? "silkworm"
                
                //if all good, we can return
                return
            }
        }
        
        //if here, we have an issue
        fatalError("Could not load start.txt from bundle.")
            
    }
    
    func addNewWord() {
        //lowercasing + trimming word
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if current answer is empty
        guard answer.count > 0 else { return }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Too short!", message: "Your answer should have more than 3 letters!")
            return
        }
        
        guard isNotStart(word: answer) else {
            wordError(title: "Can't be Root Word!", message: "Make NEW words from the root!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        
        score = score + (answer.count * 100)
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool {
        word.count > 3
    }
    
    func isNotStart(word: String) -> Bool {
        !(word == rootWord)
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
