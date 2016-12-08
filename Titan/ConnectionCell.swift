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
    // MARK: - Outlet
    
    
    //
    // MARK: - Variable
    
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initCommon() {
        
    }
    
    /// Appearance
    func initAppearance() {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
    }
    
    //
    // MARK: - Public
    func configureCell(with databaseObj: DatabaseObj) {
        
        self.textField!.stringValue = databaseObj.name
    }
    
    
    /// Database Btn Tapped
    @IBAction func databaseBtnTapped(_ sender: NSButton) {
        
    }
}
