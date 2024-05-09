//
//  ContentView.swift
//  Moonshot
//
//  Created by Lexi Han on 2024-05-06.
//

import SwiftUI


struct ContentView: View {
    @State private var showGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if showGrid {
                        GridLayout(missions: missions, astronauts: astronauts)
                    } else {
                        ListLayout(missions: missions, astronauts: astronauts)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Toggle Grid/List") {
                    showGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
