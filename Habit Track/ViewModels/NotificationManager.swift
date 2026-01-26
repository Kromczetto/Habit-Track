//
//  NotificationManager.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 19/01/2026.
//

import Foundation
import UserNotifications

final class NotificationManager {

    static let shared = NotificationManager()
    private init() {}

    private let center = UNUserNotificationCenter.current()

    func requestPermission(completion: ((Bool) -> Void)? = nil) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("Notification permission error: \(error)")
            }
            DispatchQueue.main.async {
                completion?(granted)
            }
        }
    }
    
    func scheduleDailyCompletionReminder() {
        let identifier = "habit.daily.completion"

        let content = UNMutableNotificationContent()
        content.title = "Check your habits"
        content.body = "You still have habits to complete today."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 6 * 60 * 60, // set to 6 * 60 * 60 for debbug purpouse 60s
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }
    
    func cancelDailyCompletionReminder() {
        center.removePendingNotificationRequests(
            withIdentifiers: ["habit.daily.completion"]
        )
    }
    
    func scheduleStreakNotification(habitName: String, streak: Int) {
        let identifier = "habit.streak.\(habitName).\(streak)"

        let content = UNMutableNotificationContent()
        content.title = "Great job!"
        content.body = "🔥 \(streak) days streak for \"\(habitName)\""
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }
    
    func cancelAllNotifications() {
         center.removeAllPendingNotificationRequests()
     }
}
