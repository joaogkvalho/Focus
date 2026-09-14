//
//  NotificationsService.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 03/09/26.
//

import Foundation
import UserNotifications

final class NotificationsService {
    private let center = UNUserNotificationCenter.current()
    
    func requestPermission() {
        center.requestAuthorization(
            options: [.alert, .sound, .badge],
        ) { granted, error in
            if let error {
                print("Notification permission error:", error)
            } else {
                print("Notifications permission:", granted)
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, after interval: TimeInterval) {
        cancelTimerNotification()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: max(interval, 1),
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: "pomodoro.timer",
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let error {
                print("Error scheduling notification:", error)
            }
        }
    }
    
    func cancelTimerNotification() {
        center.removePendingNotificationRequests(
            withIdentifiers: ["pomodoro.timer"]
        )
    }
}
