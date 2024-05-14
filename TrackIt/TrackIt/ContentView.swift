//
//  ContentView.swift
//  TrackIt
//
//  Created by Lexi Han on 2024-05-14.
//

import SwiftUI

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    let count: Int
}

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text("\(item.count)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                NavigationStack {
                    NavigationLink("Add Activity") {
                        AddActivity(activities: activities)
                    }
                }
            }
            .navigationTitle("TrackIt")
        }
       
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
