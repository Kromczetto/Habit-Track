//
//  ContentView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 09/09/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        BottomMenuView(modelContext: modelContext)
    }
}
