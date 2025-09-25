//
//  Habit.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 25/09/2025.
//

import Foundation
import SwiftData

@Model
class Habit {
    var habitName: String
    var habitValue: Int
    
    init(habitName: String, habitValue: Int) {
        self.habitName = habitName
        self.habitValue = habitValue
    }
}
