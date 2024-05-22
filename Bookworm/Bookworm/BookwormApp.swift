//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Lexi Han on 2024-05-20.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
