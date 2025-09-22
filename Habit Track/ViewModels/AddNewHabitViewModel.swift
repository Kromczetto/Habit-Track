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
    @Published var isError: Bool = false
    
    func addHabit() {
        if isHabitNameCorrect() && isHabitValueCorrect() {
            //Swift data
            
            habitName = ""
            habitValue = nil
            print("Adding habit :)")
        } else {
            print("There is an error \(isError)")
        }
    }
    
    private func isHabitValueCorrect() -> Bool {
        if let habitValue = habitValue {
            if habitValue > 0 && habitValue <= 10 {
                isError = false
                errorMessage = ""
                return true
            }
            isError = true
            errorMessage = "Habit value must be between 1 and 10"
            return false
        } else {
            isError = true
            errorMessage = "Habit value is required"
            return false
        }
    }
    
    private func isHabitNameCorrect() -> Bool {
        if habitName.count > 3 {
            errorMessage = ""
            isError = false
            return true
        } else {
            isError = true
            errorMessage = "Habit name must be longer than 3 characters"
        }
        return false
    }
}
