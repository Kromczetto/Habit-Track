//
//  HabitPieItem.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 02/10/2025.
//
import Foundation
import SwiftUI

struct HabitPieItem: Identifiable {
    let id = UUID()
    let name: String
    let days: Int
    let color: Color
    var check: Bool
}
