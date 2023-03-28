//
//  NotificationManager.swift
//  TODOIT
//
//  Created by alekseienko on 23.03.2023.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    private let idBody = "TODOIT.NOTIFICATION"

}

    // MARK: - Registration and Setting

extension NotificationManager {
    
    func registerNotification() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { grented, erorr in
            print(grented)
            if grented {
                
            }
        }
    }
    
    private func getNotificationSetting() {
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            guard setting.authorizationStatus == .authorized else { return }
            print(setting)
        }
    }
}

    // MARK: - Create Notification

extension NotificationManager {
    
    public func createNotification(for task: Task) {
        
        guard let taskDate = task.date else {return}
        let currentDate = Date()
    
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "Агов! Тут є завтдння для тебе!"
        content.subtitle = "За виконання +1 в карму 👍"
        
        var idTask = String()
        
        if let name = task.name {
            content.body = name
            
            idTask = name + idBody
        }
        
        let timeInterval = taskDate.timeIntervalSince(currentDate)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: idTask, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                
            }
        }
    }
}

    // MARK: - UNUserNotificationCenterDelegate

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound])
    }
}

    // MARK: - Delete Notification

extension NotificationManager {
    
    public func deletekNotification(for task: Task) {
        
        var idTask = String()
        if let name = task.name {
            idTask = name + idBody
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [idTask])
    }
}
