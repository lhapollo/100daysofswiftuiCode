//
//  DetailView.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        Form {
            Section {
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Address: \(user.address)")
                Text("Email: \(user.email)")
            }
            
            Section {
                Text("About: \(user.about)")
            }
            
            Section("Friends" ){
                List(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .padding()
        .navigationTitle(user.name)
        .scrollBounceBehavior(.basedOnSize)
    }
}
