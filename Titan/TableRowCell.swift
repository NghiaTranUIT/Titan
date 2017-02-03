//
//  ColumnDatabaseRowCel.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class TableRowCell: NSCollectionViewItem {

    //
    // MARK: - OUTLET
    
    @IBOutlet weak var tableImageView: NSImageView!
    @IBOutlet weak var tableTitleLbl: NSTextField!
    @IBOutlet weak var hoverButton: NSButton!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func hoverBtnTapped(_ sender: Any) {
        
    }
}
