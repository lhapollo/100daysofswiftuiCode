//
//  ContentView.swift
//  UnitConverter
//
//  Created by Lexi Han on 2024-04-16.
//

import SwiftUI

struct ContentView: View {
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    @State private var inputUnit = "Seconds"
    @State private var outputUnit = "Days"
    @State private var input = 0.0
    
    @FocusState private var isFocused: Bool
    
    var output: Double {
        //convert everything to seconds
        var convertedInput = input
        
        if (inputUnit == "Days") {convertedInput *= 86400.0}
        else if (inputUnit == "Hours") {convertedInput *= 3600.0}
        else if (inputUnit == "Minutes") {convertedInput *= 60.0}
        
        //convert back to desired unit
        var convertedOutput = convertedInput
        if (outputUnit == "Days") {convertedOutput /= 86400.0}
        else if (outputUnit == "Hours") {convertedOutput /= 3600.0}
        else if (outputUnit == "Minutes") {convertedOutput /= 60.0}
        return convertedOutput
    }
   
    var body: some View {
        NavigationStack {
            Form {
                Section("Select your input unit:") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select your output unit:"){
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter Initial Quantity") {
                    TextField("Time", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                
                Section("Input") {
                    Text("\(input, specifier: "%.5f") \(inputUnit)")
                }
                
                Section("Output") {
                    Text("\(output, specifier: "%.5f") \(outputUnit)")
                }
            }
            .navigationTitle("Time Conversion")
            .toolbar {
                if isFocused {
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
