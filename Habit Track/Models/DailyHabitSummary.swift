//
//  HabitSummary.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 13/11/2025.
//
import Foundation

struct DailyHabitSummary: Identifiable {
    let id = UUID()
    let date: Date
    let totalValue: Int
}
