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
        let sortedHabits = habitViewModel.habits.sorted { $0.totalDay > $1.totalDay }

        var result: [HabitPieItem] = []
        var otherDays = 0
        
        for (index, habit) in sortedHabits.enumerated() {
            if index < 5 {
                result.append(HabitPieItem(name: habit.habitName, days: habit.totalDay, color: colors[index % colors.count], check: habit.check))
            } else {
                otherDays += habit.totalDay
            }
        }
        
        if otherDays > 0 {
            result.append(HabitPieItem(name: "Other", days: otherDays, color: colors[5], check: false))
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
