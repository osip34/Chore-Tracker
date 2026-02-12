//
//  Chore_TrackerApp.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 10.02.2026.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct Chore_TrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
