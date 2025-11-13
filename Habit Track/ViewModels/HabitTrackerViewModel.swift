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
        var calendar = habit.stats

        if habit.lastCheckedDate == today && habit.check == true {
            calendar[today] = false
            habit.totalDay = max(habit.totalDay - 1, 0)
            habit.lastCheckedDate = today
            habit.stats = calendar
            habit.check = false
            return false
        }

        calendar[today] = true
        habit.totalDay += 1
        habit.lastCheckedDate = today
        habit.stats = calendar
        habit.check = true
        return true 
    }
    
    static func remainder(_ habit: Habit) -> Bool {
       guard let lastDate = habit.lastCheckedDate else {
           return true
       }

       let now = Date()
       let calendar = Calendar.current

       if let hours = calendar.dateComponents([.hour], from: lastDate, to: now).hour {
           return hours >= 6
       }

       return false
   }
   
    static func checkBreakStreak(_ habit: Habit) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        let calendar  = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        guard let lastDate = habit.lastCheckedDate else {
            return true
        }
        
        return lastDate < yesterday ? true : false
    }
}
