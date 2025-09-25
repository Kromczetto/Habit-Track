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
    @StateObject var habitViewModel: HabitViewModel
    @State private var check: Bool = false
    
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
                    if habitViewModel.habits.isEmpty {
                        VStack {
                            Text("You do not have any habits yet")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.secondaryText)
                        }
                        .background(Color.backgroundMain)
                        .listRowBackground(Color.backgroundMain)
                    } else {
                        ForEach(habitViewModel.habits, id: \.self) { habit in
                            HStack {
                                Button {
                                    habitViewModel.toggleCheck(for: habit)
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(habit.check ? .green : .gray)
                                }
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
                        .onDelete(perform: habitViewModel.deleteHabit)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundMain)
            }
        }
    }
}
