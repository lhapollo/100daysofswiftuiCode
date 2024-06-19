//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Lexi Han on 2024-06-19.
//

import SwiftUI

struct EditProspectView: View {
    @State var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $prospect.name)
                    .textContentType(.name)
                TextField("Email address", text: $prospect.emailAddress)
                    .textContentType(.emailAddress)
            }
            .navigationTitle("Edit Contact")
        }
    }
}

