//
//  TrackingButton.swift
//  Titan
//
//  Created by Nghia Tran on 1/27/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class TrackingButton: NSButton {

    //
    // MARK: - Variable
    fileprivate var trackingArea: NSTrackingArea?
    
    //
    // MARK: - Initializer
    convenience init() {
        self.init()
        self.setupTrackingArea()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTrackingArea()
    }
    
    fileprivate func setupTrackingArea() {
        if self.trackingArea == nil {
            self.trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
            self.addTrackingArea(self.trackingArea!)
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        Logger.info("ENTER")
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        Logger.info("EXIT")
    }
}
