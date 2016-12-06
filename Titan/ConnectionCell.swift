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
    // Connection Lbl
    @IBOutlet weak var connectionLbl: NSTextField!
    
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    //
    // MARK: - Public
    func configureCell(with databaseObj: DatabaseObj) {
        
        self.connectionLbl.stringValue = databaseObj.name
    }
}
