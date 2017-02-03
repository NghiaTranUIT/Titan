//
//  ColumnDatabaseRowCel.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class TableRowCell: NSCollectionViewItem {

    //
    // MARK: - Variable
    fileprivate var table: Table?
    
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
    
    func configureCell(with table: Table) {
        self.table = table
        self.setupData()
    }
    
    @IBAction func hoverBtnTapped(_ sender: Any) {
        
    }
}

//
// MARK: - Private
extension TableRowCell {
    
    fileprivate func setupData() {
        guard let table = self.table else {return}
        
        self.tableTitleLbl.stringValue = table.tableName ?? "Unknow"
    }
}
