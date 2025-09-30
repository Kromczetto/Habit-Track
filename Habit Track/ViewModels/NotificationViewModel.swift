//
//  NotificationViewModel.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 30/09/2025.
//
import UserNotifications

class NotificationViewModel {
    static func askNotificationPersmission() {
        let hasAskedBefore = UserDefaults.standard.bool(forKey: "hasAskedBefore")
        guard !hasAskedBefore else { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.scheduleNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello, world!!!!"
        content.subtitle = "This is a subtitle."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
