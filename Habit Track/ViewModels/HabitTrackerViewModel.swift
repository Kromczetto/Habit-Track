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
            habit.totalDay += 1
            habit.lastCheckedDate = today
            habit.stats[today] = true
            habit.check = true
            return true
        }
        
        print("You make this habit today")
        return false
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
    
}
