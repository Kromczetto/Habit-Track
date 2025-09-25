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
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondaryText)
                    .padding(.top, 80)
                List {
                    if addNewHabitViewModel.habits.isEmpty {
                        Text("You do not have any habits yet")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondaryText)
                    } else {
                        ForEach(addNewHabitViewModel.habits, id: \.self) { habit in
                            HStack {
                                Text(habit.habitName)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.secondaryText)
                                Spacer()
                                Text("\(habit.habitValue)")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.secondaryText)
                            }
                            .listRowBackground(Color.backgroundMain)
                        }
                        .onDelete(perform: addNewHabitViewModel.deleteHabit)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundMain)
            }
        }
    }
}
