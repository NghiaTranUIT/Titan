//
//  ConnectionCell.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ConnectionCellDelegate: class {
    func ConnectionCellShouldResetAllSelectionState()
    func ConnectionCellDidSelectedCell(sender: ConnectionCell, databaseObj: DatabaseObj, isSelected: Bool)
}

class ConnectionCell: NSCollectionViewItem {

    
    //
    // MARK: - Variable
    var databaseObj: DatabaseObj?
    weak var delegate: ConnectionCellDelegate?
    
    
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
        self.view.backgroundColor = NSColor.red
    }
    
    
    //
    // MARK: - Public
    func configureCell(with databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
        self.setupData()
    }
    
    override var isSelected: Bool {
        didSet {
            self.setupSelectionState()
        }
    }
    
    @IBAction func cellSelectedBtnTApped(_ sender: Any) {
        guard let databaseObj = self.databaseObj else {return}
        guard self.isSelected == false else {return}
        
        self.delegate?.ConnectionCellShouldResetAllSelectionState()
        self.isSelected = !self.isSelected
        self.delegate?.ConnectionCellDidSelectedCell(sender: self, databaseObj: databaseObj, isSelected: self.isSelected)
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
