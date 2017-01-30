//
//  MainWindowController.swift
//  Titan
//
//  Created by Nghia Tran on 1/30/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        NotificationManager.observeNotificationType(.closeConnectionWindow, observer: self, selector: #selector(self.closeWindow), object: nil)
    }
    
    @objc func closeWindow() {
        self.close()
    }
    
}
