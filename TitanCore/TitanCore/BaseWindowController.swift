//
//  BaseWindowController.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

open class BaseWindowController: NSWindowController {

    //
    // MARK: - View Cycle
    
    override open func windowDidLoad() {
        super.windowDidLoad()
        
        self.initCommon()
        self.initObserver()
    }
    
    override open func showWindow(_ sender: Any?) {
        
        // Restore previous frame
        self.restorePreviousWindowFrame()
        
        super.showWindow(sender)
    }
    
    deinit {
        Logger.info("Window %@ is closed")
    }
    
    override open func close() {
        super.close()
    }

}

//
// MARK: - Private
extension BaseWindowController {
    
    fileprivate func initCommon() {
        guard let window = self.window else {return}
        
        // Layer
        if let view = window.contentView {
            view.wantsLayer = true
        }
        
        window.styleMask.insert(.fullSizeContentView)
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        
        // Release mode
        window.isReleasedWhenClosed = true
        
        // Delegate
        window.delegate = self
    }
    
    fileprivate func initObserver() {
        
    }
    
    fileprivate func restorePreviousWindowFrame() {
        guard let window = self.window else {return}
        guard let screen = NSScreen.main() else {return}
        
        // Get last
        var previousFrame = AppPreferences.shared.mainWindowFrame
        
        // Prevent it's too big for screen
        if previousFrame.size.height > screen.frame.size.height {
            previousFrame.size.height = screen.frame.size.height
        }
        
        window.setFrame(previousFrame, display: true)
    }
}

//
// MARK: - NSWindowDelegate
extension BaseWindowController: NSWindowDelegate {
    
    public func windowWillClose(_ notification: Notification) {
        guard let window = self.window else {return}
        
        // Save last previous frame
        AppPreferences.shared.mainWindowFrame = window.frame
    }
}
