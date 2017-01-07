//
//  ConnectionCell.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ConnectionCell: NSCollectionViewItem {

    
    //
    // MARK: - Variable
    fileprivate var databaseObj: DatabaseObj?
    
    //
    // MARK: - Outlet
    
    // Database icon
    @IBOutlet weak var databaseIconImageView: NSImageView!
    
    // Title
    @IBOutlet weak var titleLbl: NSTextField!
    

    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    
    /// Common
    override func initCommon() {
        
    }
    
    
    /// Appearance
    override func initUIs() {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
    }
    
    
    //
    // MARK: - Public
    func configureCell(with databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
        self.setupData()
    }
}


//
// MARK: - Private
extension ConnectionCell {
    
    // Setup
    fileprivate func setupData() {
        guard let databaseObj = self.databaseObj else {return}
        
        // Title
        self.titleLbl.stringValue = databaseObj.name
        
        // Select state
        self.setupSelectionState()
    }
    
    fileprivate func setupSelectionState() {
        
        // Selected
        if self.isSelected {
            self.databaseIconImageView.image = NSImage(named: "icon_database_selected")
            self.view.backgroundColor = NSColor(hexString: "#F4F5F9")
            self.titleLbl.textColor = NSColor(hexString: "#606872")
            return
        }
        
        // Non-selected
        self.databaseIconImageView.image = NSImage(named: "icon_database")
        self.view.backgroundColor = NSColor.white
        self.titleLbl.textColor = NSColor(hexString: "#8D9298")
    }
}
