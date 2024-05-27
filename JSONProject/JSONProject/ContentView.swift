//
//  ContentView.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
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
                if (users.isEmpty) {
                    await loadData()
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
            DispatchQueue.main.async {
                users = decodedUsers
            }
        } catch {
            print("Invalid data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
