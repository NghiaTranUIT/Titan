//
//  StackTableCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class StackTableCell: NSCollectionViewItem {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableImageView: NSImageView!
    @IBOutlet weak var tableTitleLbl: NSTextField!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func configureCell(with table: Table) {
        self.tableTitleLbl.stringValue = table.tableName!
    }
}
