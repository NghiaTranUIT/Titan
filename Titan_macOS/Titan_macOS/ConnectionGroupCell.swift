//
//  ConnectionGroupCell.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ConnectionGroupCell: NSView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: NSTextField!
    @IBOutlet weak var addDatabaseBtn: NSButton!
    
    //
    // MARK: - Variable
    private var groupConnectionObj: GroupConnectionObj!
    fileprivate var trackingArea: NSTrackingArea?
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.setupTrackingArea()
    }
    
    //
    // MARK: - Action
    @IBAction func addBtnTapped(_ sender: NSButton) {
        
    }
    
    //
    // MARK: - Public
    
    /// Configure
    func configureCellWith(groupConnectionObj: GroupConnectionObj) {
        self.groupConnectionObj = groupConnectionObj
        
        // Setup
        self.titleLbl.stringValue = groupConnectionObj.name
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        self.addDatabaseBtn.alphaValue = 1
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        self.addDatabaseBtn.alphaValue = 0
    }
}

//
// MARK: - Private
extension ConnectionGroupCell {
    
    fileprivate func initCommon() {
        self.addDatabaseBtn.alphaValue = 0
    }
    
    fileprivate func setupTrackingArea() {
        if self.trackingArea == nil {
            self.trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
            self.addTrackingArea(self.trackingArea!)
        }
    }
}

