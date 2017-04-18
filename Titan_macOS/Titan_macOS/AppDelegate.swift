//
//  AppDelegate.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/3/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //
    // MARK: - Variable
    fileprivate var listDatabasesWindow: MainWindowController?
    fileprivate lazy var detailDatabaseWindow: DetailDatabaseWindowController = self.initDetailWindow()
    
    //
    // MARK: - Cycle
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
        self.listDatabasesWindow = MainWindowController.controllerFromStoryboard(type: MainWindowController.self, storyboardName: .Main)
        self.listDatabasesWindow?.showWindow(self)
        self.listDatabasesWindow!.window?.makeKeyAndOrderFront(self)
        
    }

    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showDetailWindow() {
        self.detailDatabaseWindow.showWindow(self)
        self.detailDatabaseWindow.window?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func realmLocationBtnTapped(_ sender: Any) {
        AppPreferences._dreamDatabaseLocation()
    }
}

//
// MARK: - Private
extension AppDelegate {
    
    /// Get detail window
    fileprivate func initDetailWindow() -> DetailDatabaseWindowController {
        return DetailDatabaseWindowController.controllerFromStoryboard(type: DetailDatabaseWindowController.self, storyboardName: .DetailConnection)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.listDatabasesWindow?.close()
        }
    }
}

