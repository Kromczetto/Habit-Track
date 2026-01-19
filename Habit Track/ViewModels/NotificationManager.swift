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

    func checkPermissionStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }

    func scheduleDailyReminder(for habitName: String, at time: Date) {
        let identifier = dailyIdentifier(for: habitName)

        let content = UNMutableNotificationContent()
        content.title = "Habit reminder"
        content.body = "Don't forget to complete: \(habitName)"
        content.sound = .default

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)

        var triggerComponents = DateComponents()
        triggerComponents.hour = components.hour
        triggerComponents.minute = components.minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    func scheduleSmartReminder(for habitName: String, fireAfter seconds: TimeInterval) {
        let identifier = smartIdentifier(for: habitName)

        let content = UNMutableNotificationContent()
        content.title = "Still time!"
        content.body = "You haven't completed \"\(habitName)\" today."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: seconds,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    func scheduleStreakNotification(habitName: String, streak: Int) {
        let identifier = streakIdentifier(for: habitName, streak: streak)

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

    func cancelDailyReminder(for habitName: String) {
        center.removePendingNotificationRequests(
            withIdentifiers: [dailyIdentifier(for: habitName)]
        )
    }

    func cancelSmartReminder(for habitName: String) {
        center.removePendingNotificationRequests(
            withIdentifiers: [smartIdentifier(for: habitName)]
        )
    }

    func cancelAllReminders(for habitName: String) {
        center.removePendingNotificationRequests(
            withIdentifiers: [
                dailyIdentifier(for: habitName),
                smartIdentifier(for: habitName)
            ]
        )
    }

    func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }

    private func dailyIdentifier(for habitName: String) -> String {
        "habit.daily.\(habitName)"
    }

    private func smartIdentifier(for habitName: String) -> String {
        "habit.smart.\(habitName)"
    }

    private func streakIdentifier(for habitName: String, streak: Int) -> String {
        "habit.streak.\(habitName).\(streak)"
    }
}
