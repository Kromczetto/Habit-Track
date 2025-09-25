//
//  AddNewHabitViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import Foundation
import SwiftData

class AddNewHabitViewModel: ObservableObject {
    @Published var habitName: String = ""
    @Published var habitValue: Int = 1
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false

    var habits = [Habit]()
    
    init(modelContext: ModelContext) {
        fetchData(modelContext: modelContext)
    }
    
    func fetchData(modelContext: ModelContext) {
        do {
            let descriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.habitName)])
            habits = try modelContext.fetch(descriptor)
            print("We have some habits")
        } catch {
            print("Problem with fetching data")
        }
    }
    
    func addHabit(modelContext: ModelContext) {
        if isHabitNameCorrect() {
            let habit = Habit(habitName: self.habitName, habitValue: self.habitValue)
            modelContext.insert(habit)
            fetchData(modelContext: modelContext)
            habitName = ""
            habitValue = 1
            print("Adding habit :)")
        } else {
            print("There is an error \(isError)")
        }
    }
    
    private func isHabitNameCorrect() -> Bool {
        if habitName.trimmingCharacters(in: .whitespaces).count > 3 &&
            habitName.trimmingCharacters(in: .whitespaces).count < 50 {
            errorMessage = ""
            isError = false
            if containsSpecialCharacter(habitName.trimmingCharacters(in: .whitespaces)) {
                isError = true
                errorMessage = "Habit name can not contain special characters"
                return false
            } else {
                isError = false
                errorMessage = ""
                return true
            }
        } else {
            if habitName.trimmingCharacters(in: .whitespaces).count <= 3 {
                isError = true
                errorMessage = "Habit name must be longer than 3 characters"
            } else {
                isError = true
                errorMessage = "Habit name must be shorter than 50 characters"
                habitName = ""
            }
        }
        return false
    }
    
    private func containsSpecialCharacter(_ input: String) -> Bool {
        let allowedCharacters = CharacterSet.alphanumerics.union(.whitespaces)
        return input.rangeOfCharacter(from: allowedCharacters.inverted) != nil ? true : false
    }
    
}
