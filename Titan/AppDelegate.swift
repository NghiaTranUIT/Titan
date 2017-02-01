//
//  AppDelegate.swift
//  Titan
//
//  Created by Nghia Tran Vinh on 9/25/16.
//  Copyright © 2016 fe. All rights reserved.
//


////////////////////////////////////////////////////////////////
//   Created by : Nghia Tran
//   Sun, 25th Sept 2016
//   Saigon, Vietnam
////////////////////////////////////////////////////////////////


import Cocoa
import ReSwift

// Main State 
let mainStore = Store<MainAppState>(reducer: MainReducer(), state: nil, middleware: [])

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //
    // MARK: - Variable
    fileprivate var listDatabasesWindow: MainWindowController?
    fileprivate lazy var detailDatabaseWindow: DetailDatabaseWindowController = self.initDetailWindow()
    
    //
    // MARK: - Action
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Configure SDKs
        ApplicationManager.sharedInstance.initAllSDKs()
        
        // Init Common things
        ApplicationManager.sharedInstance.initCommon(window: NSApplication.shared().mainWindow)
        
        // Default Data
        ApplicationManager.sharedInstance.importDefaultDataIfNeed()
        
        // Observe notificatino
        self.observeNotification()
        
        // Show List database window
        self.listDatabasesWindow = self.initListDatabasesWindow()
        self.listDatabasesWindow?.showWindow(self)
        self.listDatabasesWindow!.window?.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func showDetailWindow() {
        self.detailDatabaseWindow.showWindow(self)
        self.detailDatabaseWindow.window?.makeKeyAndOrderFront(self)
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
}

//
// MARK: - Private
extension AppDelegate {
    
    /// Get Main window
    fileprivate func initListDatabasesWindow() -> MainWindowController {
        let storyboard = NSStoryboard(name: "Connection", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "MainWindowController") as! MainWindowController
    }
    
    /// Get detail window
    fileprivate func initDetailWindow() -> DetailDatabaseWindowController {
        let storyboard = NSStoryboard(name: "DetailConnection", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "DetailDatabaseWindowController") as! DetailDatabaseWindowController
    }
    
    /// Obverse
    fileprivate func observeNotification() {
        NotificationManager.observeNotificationType(NotificationType.openDetailDatabaseWindow, observer: self, selector: #selector(self.openDetailWindowNotification(noti:)), object: nil)
    }
}

//
// MARK: - Notification
extension AppDelegate {
    
    @objc fileprivate func openDetailWindowNotification(noti: Notification) {
        
        // Open first
        self.showDetailWindow()
        
        // Close
        self.listDatabasesWindow?.close()
//        self.listDatabasesWindow = nil
    }
}
