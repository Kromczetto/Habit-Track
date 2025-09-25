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
    @Attribute(.unique) var habitName: String
    var habitValue: Int
    var check: Bool = false
    
    init(habitName: String, habitValue: Int, check: Bool = false) {
        self.habitName = habitName
        self.habitValue = habitValue
        self.check = check
    }
}
