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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

