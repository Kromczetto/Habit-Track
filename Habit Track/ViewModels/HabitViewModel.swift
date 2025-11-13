//
//  AddNewHabitViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import Foundation
import SwiftData

class HabitViewModel: ObservableObject {
    @Published var habitName: String = ""
    @Published var habitValue: Int = 1
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var habits: [Habit] = []
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.habitValue)])
            habits = try modelContext.fetch(descriptor)
            
            let today = Calendar.current.startOfDay(for: Date())
            for habit in habits {
                if habit.lastCheckedDate != today {
                    habit.check = false
                }
            }
            print("We have some habits")
        } catch {
            print("Problem with fetching data")
        }
    }
    
    func addHabit() {
        if isHabitNameCorrect() {
            let habit = Habit(habitName: self.habitName, habitValue: self.habitValue, check: false, stats: [Date(): true])
            modelContext.insert(habit)
            do {
               try modelContext.save()
               fetchData()
            } catch {
               print("Problem with saving context: \(error)")
            }
            habitName = ""
            habitValue = 1
            print("Adding habit :)")
        } else {
            print("There is an error \(isError)")
        }
    }
    
    func toggleCheck(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].check.toggle()
            try? modelContext.save()
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        let toDelete = offsets.map { habits[$0] }
                
        for habit in toDelete {
            modelContext.delete(habit)
        }
        
        do {
            try modelContext.save()
            fetchData()
        } catch {
            print("Problem with saving context after delete: \(error)")
        }
    }
    
    private func isHabitNameCorrect() -> Bool {
        if !checkIsNameFree() {
            habitName = ""
            return false
        }
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
    
    private func checkIsNameFree() -> Bool {
        let clearedName = habitName.trimmingCharacters(in: .whitespaces).lowercased()
        for habit in habits {
            if habit.habitName.lowercased() == clearedName {
                isError = true
                errorMessage = "Habit name already exists"
                return false
            }
        }
        return true
    }
    
    private func containsSpecialCharacter(_ input: String) -> Bool {
        let allowedCharacters = CharacterSet.alphanumerics.union(.whitespaces)
        return input.rangeOfCharacter(from: allowedCharacters.inverted) != nil ? true : false
    }
    
    func getLast30DaysSummary() -> [DailyHabitSummary] {
        var result: [DailyHabitSummary] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                var totalValue = 0
                for habit in habits {
                    if habit.stats[date] == true {
                        totalValue += habit.habitValue
                    }
                }
                result.append(DailyHabitSummary(date: date, totalValue: totalValue))
            }
        }
        
        return result.sorted(by: { $0.date < $1.date })
    }
}
