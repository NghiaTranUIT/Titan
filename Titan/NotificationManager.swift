//
//  NotificationManager.swift
//  Titan
//
//  Created by Nghia Tran on 1/15/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

enum NotificationType: String {
    
    // Preifx
    private static let NotificationPrefix = "com.fe.titan"
    
    // Enum
    case prepareLayoutForSelectedDatabase
    case groupConnectionChanged
    case saveCurrentDatabaseObj
    case openDetailDatabaseWindow
    case windowWillClose
    case tableStateChanged
    case stackTableStateChanged
    
    // To String
    func toString() -> String {
        if self.rawValue == NotificationType.windowWillClose.rawValue {
            return Notification.Name.NSWindowWillClose.rawValue
        }
        return NotificationType.NotificationPrefix + self.rawValue
    }
}

class NotificationManager {
    
    class func postNotificationOnMainThreadType(_ type: NotificationType, object: AnyObject? = nil, userInfo: [String: Any]? = nil) {
        
        // Send
        NotificationCenter.default.postNotificationOnMainThreadName(type.toString(), object: object, userInfo: userInfo)
    }
    
    class func observeNotificationType(_ type: NotificationType, observer: AnyObject, selector aSelector: Selector, object anObject: AnyObject?) {
        // Observe
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(rawValue: type.toString()), object: anObject)
    }
    
    class func removeAllObserve(_ observer: AnyObject) {
        
        // Remove
        NotificationCenter.default.removeObserver(observer)
    }
}

extension NotificationCenter {
    
    func postNotificationOnMainThreadName(_ name: String, object: AnyObject?, userInfo: [String: Any]?) {
        
        // Create new Internal Notification
        let noti = Notification(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
        
        self.performSelector(onMainThread: #selector(post(_:)), with: noti, waitUntilDone: true)
    }
}
