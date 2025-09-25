//
//  Habit_TrackApp.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 09/09/2025.
//

import SwiftUI
import SwiftData

@main
struct Habit_TrackApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            //let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Problem with creating ModelContainer")
        }
    }
    
}
