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
    @StateObject private var appLanguageManager = AppLanguageManager()
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Problem with creating ModelContainer: \(error)")
        }
        
        NotificationManager.shared.requestPermission { granted in
            if granted {
                print("Notifications permission granted")
            } else {
                print("Notifications permission denied")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .preferredColorScheme(.light)
                .environment(\.locale, appLanguageManager.locale)
                .environmentObject(appLanguageManager)
        }
    }
}
