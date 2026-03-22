//
//  HidingKeyboard.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 22/03/2026.
//

import UIKit

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
