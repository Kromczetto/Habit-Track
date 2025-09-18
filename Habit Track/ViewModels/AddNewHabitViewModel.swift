//
//  AddNewHabitViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import Foundation

class AddNewHabitViewModel: ObservableObject {
    @Published var habitName: String = ""
    @Published var habitValue: Int?
    @Published var errorMessage: String = ""
    
    private func isHabitValueCorrect() -> Bool {
        if let habitValue = habitValue {
            if habitValue > 0 && habitValue <= 10 {
                return true
            }
            return false
        } else {
            return false
        }
    }
}
