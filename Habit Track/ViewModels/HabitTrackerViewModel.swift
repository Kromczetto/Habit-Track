//
//  HabitTrackerViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 29/09/2025.
//

import Foundation
import SwiftData

class HabitTrackerViewModel {
    
    static func markAsDone(_ habit: Habit) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        
        if habit.lastCheckedDate != today {
            habit.check = false
        }
        
        if habit.lastCheckedDate != today {
            habit.totalDay += 1
            habit.lastCheckedDate = today
            habit.stats[today] = true
            habit.check = true
            return true
        }
        
        print("You make this habit today")
        return false
    }
    
    static func countCompletedDays(_ habit: Habit, inLast days: Int ) -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        var count = 0
        
        for i in 0..<days {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: today)!
            if habit.stats[date] == true {
                count += 1
            }
        }
        return count
    }
    
    static func currentStreak(_ habit: Habit) -> Int {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            
            var streak = 0
            var day = today
            
            while let done = habit.stats[day], done {
                streak += 1
                if let previousDay = calendar.date(byAdding: .day, value: -1, to: day) {
                    day = previousDay
                } else {
                    break
                }
            }
            
            return streak
        }
    
}
