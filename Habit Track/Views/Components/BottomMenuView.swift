//
//  BottomMenuView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import SwiftUI
import SwiftData

struct BottomMenuView: View {
    @State private var index: Int = 0
    @Environment(\.modelContext) private var modelContext
    @StateObject var addNewHabitViewModel: AddNewHabitViewModel
    
    init(modelContext: ModelContext) {
        _addNewHabitViewModel = StateObject(wrappedValue: AddNewHabitViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        TabView(selection: $index) {
            NavigationView {
                HomeView(addNewHabitViewModel: addNewHabitViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            NavigationView {
                AddNewHabitView(addNewHabitViewModel: addNewHabitViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Add", systemImage: "plus.app.fill")
            }
            .tag(1)
            NavigationView {
                ProfileView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(2)
        }
    }
}
