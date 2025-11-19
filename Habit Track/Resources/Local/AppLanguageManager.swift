//
//  AppLanguageManager.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 19/11/2025.
//

import Foundation

class AppLanguageManager: ObservableObject {
    @Published var locale: Locale = .current
    
    func setLanguage(_ code: String) {
        locale = Locale(identifier: code)
    }
}
