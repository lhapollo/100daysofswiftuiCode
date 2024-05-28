//
//  JSONProjectApp.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import SwiftUI
import SwiftData

@main
struct JSONProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
