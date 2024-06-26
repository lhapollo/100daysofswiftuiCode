//
//  ContentView.swift
//  DiceRollers
//
//  Created by Lexi Han on 2024-06-25.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var result = ""
    @State private var rollHistory = [String]()
    @State private var numberOfDice = 1
    @State private var sidesOfDice = 6
    @State private var engine: CHHapticEngine?
    @State private var isRolling = false

    var body: some View {
        VStack {
            Section{
                Text("How many dice?")
                Picker("Number of Dice", selection: $numberOfDice) {
                    ForEach(1..<11) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }

            Section {
                Text("How many sides per dice?")
                Picker("Sides of Dice", selection: $sidesOfDice) {
                    ForEach([4, 6, 8, 10, 12, 20, 100], id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }

            Button("Roll Dice") {
                rollDice()
            }
            .padding()
            .disabled(isRolling)
            .accessibility(label: Text("Roll Dice"))

            Text(result)
                .padding()

            List(rollHistory, id: \.self) { roll in
                Text(roll)
            }
        }
        .onAppear(perform: prepareHaptics)
        .onAppear(perform: loadRollHistory)
    }

    func rollDice() {
        playHapticFeedback()

        isRolling = true
        var total = 0
        var rolls = [Int]()
        for _ in 1...(numberOfDice+1) {
            rolls.append(Int.random(in: 1...sidesOfDice))
        }

        var currentRolls = rolls
        let animationDuration = 1.0
        let interval = 0.1
        var elapsedTime = 0.0

        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            for i in 0..<currentRolls.count {
                currentRolls[i] = Int.random(in: 1...self.sidesOfDice)
            }
            result = "Rolling: \(currentRolls.map(String.init).joined(separator: ", "))"

            elapsedTime += interval
            if elapsedTime >= animationDuration {
                timer.invalidate()
                for roll in rolls {
                    total += roll
                }
                result = "You rolled: \(rolls.map(String.init).joined(separator: ", ")) (Total: \(total))"
                rollHistory.append(result)
                saveRollHistory()
                isRolling = false
            }
        }
    }

    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }

    func playHapticFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: i, duration: 0.1)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }

    func saveRollHistory() {
        if let encoded = try? JSONEncoder().encode(rollHistory) {
            UserDefaults.standard.set(encoded, forKey: "RollHistory")
        }
    }

    func loadRollHistory() {
        if let savedData = UserDefaults.standard.data(forKey: "RollHistory"),
           let savedHistory = try? JSONDecoder().decode([String].self, from: savedData) {
            rollHistory = savedHistory
        }
    }
}

#Preview {
    ContentView()
}
