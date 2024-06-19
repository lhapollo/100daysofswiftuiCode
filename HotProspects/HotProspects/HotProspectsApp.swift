//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Lexi Han on 2024-06-15.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
