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
        content.title = "You still have habits to complete!"
        content.subtitle = "Keep improving every single day!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10800, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
