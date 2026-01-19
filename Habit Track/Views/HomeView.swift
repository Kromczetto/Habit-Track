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
    @State private var showCalendar = false
    @State private var showSwipeHint: Bool = true
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            
            VStack {
                Text("Built your habit every day")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondaryText)
                    .padding(.top, 40)
                
                Spacer()
                
                if showSwipeHint {
                    Text("Swipe item left to delete")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .transition(.opacity)
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
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
                        ForEach(habitViewModel.habits, id: \.id) { habit in
                            HStack {
                                Button {
                                    if HabitTrackerViewModel.markAsDone(habit) {
                                       try? modelContext.save()
                                       habitViewModel.fetchData()
                                   }
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
                                if habit.check {
                                    Button() {
                                        showCalendar.toggle()
                                    } label: {
                                        Image(systemName: "calendar")
                                    }
                                    .buttonStyle(.plain)
                                    .sheet(isPresented: $showCalendar) {
                                        CalendarView(checkDays: habit.stats)
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                            .listRowBackground(Color.backgroundMain)
                        }
                        .onDelete(perform: habitViewModel.deleteHabit)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundMain)
                .onAppear {
                    habitViewModel.fetchData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            showSwipeHint = false
                        }
                    }
            
                    for habit in habitViewModel.habits {
                        if HabitTrackerViewModel.checkBreakStreak(habit) {
                            habit.totalDay = 0
                            try? modelContext.save()
                            habitViewModel.fetchData()
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}
