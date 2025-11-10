//
//  CalendarViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 13/10/2025.
//
import Foundation

class CalendarViewModel {
    static var firstDayOfWeek = Calendar.current.firstWeekday
    
    static func capitalizedFirstLetterOfWeek() -> [String] {
        let calendar = Calendar.current
        
        var weekDays = calendar.shortWeekdaySymbols
        
        if firstDayOfWeek > 1 {
            for _ in 1..<firstDayOfWeek {
                if let firstElement = weekDays.first {
                    weekDays.removeFirst()
                    weekDays.append(firstElement)
                }
            }
        }
        
        return weekDays.map { $0.capitalized }
    }
    
    static func startOfMonth(_ date: Date) -> Date {
        return Calendar.current.dateInterval(of: .month, for: date)!.start
    }
    
    static func endOfMonth(_ date: Date) -> Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: date)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    static func numberOfDayInMonth(_ date: Date) -> Int {
        Calendar.current.component(.day, from: endOfMonth(date))
    }
    
    static func firstWeekDayBeforeStart(_ date: Date) -> Date {
        let startOfMonthWeekDay = Calendar.current.component(.weekday, from: startOfMonth(date))
        var numberFromPreviousMonth = startOfMonthWeekDay - firstDayOfWeek
        if numberFromPreviousMonth < 0 {
            numberFromPreviousMonth += 7
        }
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth(date))!
    }
    
    static func displayCalendar(_ date: Date) -> [Date] {
        var days: [Date] = []
        let firstDayDisplay = firstWeekDayBeforeStart(date)
        var day = firstDayDisplay
        
        while day < startOfMonth(date) {
            days.append(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        }
        
        for dayOffSet in 0..<numberOfDayInMonth(date) {
            if let newDay = Calendar.current.date(byAdding: .day, value: dayOffSet, to: startOfMonth(date)) {
                days.append(newDay)
            }
        }
        
        return days
    }
    
    static func hasHabitBeenDone(_ date: Date, _ diary: [Date: Bool]) -> Bool {
        guard date < Date() else {
            print("Future date cannot be checked")
            return false
        }
        
        for (key, value) in diary {
            if Calendar.current.isDate(date, inSameDayAs: key) {
                return value
            }
        }
        
        return false
    }
    
    static func isTheSameDay(_ firstDate: Date, _ secondDate: Date) -> Bool {
        if Calendar.current.isDate(firstDate, inSameDayAs: secondDate) {
            return true
        }
        return false
    }
}
