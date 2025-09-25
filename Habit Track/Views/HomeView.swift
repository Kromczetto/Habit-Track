//
//  HomeView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var addNewHabitViewModel: AddNewHabitViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            VStack {
                Text("Built your habit every day")
                List(addNewHabitViewModel.habits) { habit in
                    HStack {
                        Text(habit.habitName)
                        Spacer()
                        Text("\(habit.habitValue)")
                    }
                }
            }
        }
        .onAppear {
            addNewHabitViewModel.fetchData(modelContext: modelContext)
        }
    }
}
