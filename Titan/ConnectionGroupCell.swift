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
    
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
}

