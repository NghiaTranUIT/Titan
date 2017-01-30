//
//  ConnectionGroupCell.swift
//  Titan
//
//  Created by Nghia Tran on 12/1/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa


//
// MARK: - Delegate
protocol ConnectionGroupCellDelegate: class {
    
    /// Create new database
    func ConnectionGroupCellShouldCreateNewDatabaseWithGroup(group: GroupConnectionObj)
}


//
// MARK: - ConnectionGroupCell
class ConnectionGroupCell: NSView {
    
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: NSTextField!
    @IBOutlet weak var addDatabaseBtn: NSButton!
    
    
    //
    // MARK: - Variable
    weak var delegate: ConnectionGroupCellDelegate?
    private var groupConnectionObj: GroupConnectionObj!
    fileprivate var trackingArea: NSTrackingArea?
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initBaseAbility()
        self.setupTrackingArea()
    }
    
    
    //
    // MARK: - Action
    @IBAction func addBtnTapped(_ sender: NSButton) {
        self.delegate?.ConnectionGroupCellShouldCreateNewDatabaseWithGroup(group: self.groupConnectionObj)
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
    
    internal override func initCommon() {
        super.initCommon()
        self.addDatabaseBtn.alphaValue = 0
    }
    
    fileprivate func setupTrackingArea() {
        if self.trackingArea == nil {
            self.trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
            self.addTrackingArea(self.trackingArea!)
        }
    }
}

