//
//  HabitStatisticsViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 02/10/2025.
//
import Foundation
import SwiftUI

class HabitStatisticsViewModel: ObservableObject {
    @Published var habitViewModel: HabitViewModel
    
    private let colors: [Color] = [.green, .blue, .orange, .purple, .pink, .gray]
    
    init(habitViewModel: HabitViewModel) {
        self.habitViewModel = habitViewModel
    }
    
    func topHabitsWithOther() -> [HabitPieItem] {
        let sortedHabits = habitViewModel.habits
            .map { ($0.habitName, HabitTrackerViewModel.currentStreak($0)) }
            .sorted { $0.1 > $1.1 }
        
        var result: [HabitPieItem] = []
        var otherDays = 0
        
        for (index, habit) in sortedHabits.enumerated() {
            if index < 5 {
                result.append(HabitPieItem(name: habit.0, days: habit.1, color: colors[index % colors.count]))
            } else {
                otherDays += habit.1
            }
        }
        
        if otherDays > 0 {
            result.append(HabitPieItem(name: "Other", days: otherDays, color: colors[5]))
        }
        
        return result
    }
    
    func totalWeightForToday() -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        var total = 0
        
        for habit in habitViewModel.habits {
            if let done = habit.stats[today], done {
                total += habit.habitValue
            }
        }
        
        return total
    }
    
    func totalPossibleDays() -> Int {
        habitViewModel.habits.count * 30
    }
    
}
