//
//  NotificationManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

public enum NotificationType: String {
    
    // Preifx
    private static let NotificationPrefix = "com.fe.titan"
    
    // Enum
    case prepareLayoutForSelectedDatabase
    case openDetailDatabaseWindow
    case windowWillClose
    
    // To String
    func toString() -> String {
        if self.rawValue == NotificationType.windowWillClose.rawValue {
            return Notification.Name.NSWindowWillClose.rawValue
        }
        return NotificationType.NotificationPrefix + self.rawValue
    }
}

open class NotificationManager {
    
    public class func postNotificationOnMainThreadType(_ type: NotificationType, object: AnyObject? = nil, userInfo: [String: Any]? = nil) {
        NotificationCenter.default.postNotificationOnMainThreadName(type.toString(), object: object, userInfo: userInfo)
    }
    
    public class func observeNotificationType(_ type: NotificationType, observer: AnyObject, selector aSelector: Selector, object anObject: AnyObject?) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(rawValue: type.toString()), object: anObject)
    }
    
    public class func removeAllObserve(_ observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
}

//
// MARK: - Private
extension NotificationCenter {
    
    public func postNotificationOnMainThreadName(_ name: String, object: AnyObject?, userInfo: [String: Any]?) {
        
        // Create new Internal Notification
        let noti = Notification(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
        
        self.performSelector(onMainThread: #selector(post(_:)), with: noti, waitUntilDone: true)
    }
}
