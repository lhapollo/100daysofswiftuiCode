//
//  AddActivity.swift
//  TrackIt
//
//  Created by Lexi Han on 2024-05-14.
//

import SwiftUI

struct AddActivity: View {
    @State private var name = "Activity Name"
    @State private var description = "Activity Description"
    @State private var count = 0
    
    @Environment(\.dismiss) var dismiss
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("What do you want to track?"){
                    TextField("Activity Name", text: $name)
                }
                
                Section("Describe your activity") {
                    TextField("Activity Description", text: $description)
                }
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let item = ActivityItem(name: name, description: description, count: 0)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddActivity(activities: Activities())
}

