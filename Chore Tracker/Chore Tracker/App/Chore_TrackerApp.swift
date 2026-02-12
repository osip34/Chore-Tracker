//
//  Chore_TrackerApp.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 10.02.2026.
//

import SwiftUI
import Firebase

@main
struct Chore_TrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
