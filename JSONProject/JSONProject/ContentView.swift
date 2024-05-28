//
//  ContentView.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]
    @State private var isDataLoaded = UserDefaults.standard.bool(forKey: "isDataLoaded")
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.isActive ? "Online" : "Offline")
                            .foregroundColor(user.isActive ? .green : .secondary)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if (!isDataLoaded) {
                    await loadData()
                    UserDefaults.standard.set(true, forKey: "isDataLoaded")
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            if (users.isEmpty) {
                await saveToSwiftData(users: decodedUsers)
            }
        } catch {
            print("Invalid data: \(error.localizedDescription)")
        }
    }
    
    func saveToSwiftData(users: [User]) async {
        for user in users {
            
            modelContext.insert(user)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save users: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
