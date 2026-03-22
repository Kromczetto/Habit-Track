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
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
    @StateObject var habitViewModel: HabitViewModel
    
    @State private var selectedHabitForCalendar: Habit? = nil
    @State private var showSwipeHint: Bool = true
    
    @State private var showTooltip = false
    @State private var showPaywall = false
    
    private let notificationManager = NotificationManager.shared
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            
            VStack {
                Text("Built your habit every day")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondaryText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6) 
                    .padding(.top, 40)
                    .padding(.horizontal)
                
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
                        HStack {
                            Spacer()
                            Text("You do not have any habits yet")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.secondaryText)
                                .padding()
                            Spacer()
                        }
                        .background(Color.backgroundMain)
                        .listRowBackground(Color.backgroundMain)
                    } else {
                        ForEach(habitViewModel.habits, id: \.id) { habit in
                            

                            HStack {
                     
                                Button {
                                    let completed = HabitTrackerViewModel.markAsDone(habit)
                                    try? modelContext.save()
                                    habitViewModel.fetchData()

                                    if completed {
                                        notificationManager.scheduleStreakNotification(
                                            habitName: habit.habitName,
                                            streak: habit.totalDay
                                        )
                                    }
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(habit.check ? .green : .gray)
                                }
                                .buttonStyle(.plain)
                                
                                Text(habit.habitName)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.secondaryText)
                                
                                Spacer()
                                
                                Text("\(habit.habitValue)")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.secondaryText)

                                if habit.check {
                                    if subscriptionManager.isPremium {
                                        Button {
                                            selectedHabitForCalendar = habit
                                        } label: {
                                            Image(systemName: "calendar")
                                        }
                                        .buttonStyle(.plain)
                                    } else {
                                        Button {
                                            showTooltip = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                showTooltip = false
                                            }
                                            
                                            showPaywall = true
                                        } label: {
                                            Image(systemName: "lock.fill")
                                                .foregroundColor(.gray)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .contentShape(Rectangle())
                            
                            .listRowBackground(Color.backgroundMain)
                        }
                        .onDelete(perform: habitViewModel.deleteHabit)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundMain)

                if showTooltip {
                    Text("Premium feature 🔒")
                        .padding(8)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                }
                
                Spacer()
            }
        }
        
        .sheet(item: $selectedHabitForCalendar) { habit in
            CalendarView(checkDays: habit.stats)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        
        .sheet(isPresented: $showPaywall) {
            VStack(spacing: 20) {
                Text("Go Premium")
                    .font(.largeTitle)
                
                Text("• Unlimited habits\n• Calendar access")
                
                Button("Subscribe for $0.99") {
                    Task {
                        await subscriptionManager.purchase()
                        showPaywall = false
                    }
                }
                
                Button("Restore purchases") {
                    Task {
                        await subscriptionManager.restore()
                    }
                }
            }
            .padding()
            .presentationDetents([.medium])
        }
        
        .onAppear {
            habitViewModel.fetchData()
            
            notificationManager.requestPermission()
            notificationManager.cancelDailyCompletionReminder()
            notificationManager.scheduleDailyCompletionReminder()
            
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
    }
}
