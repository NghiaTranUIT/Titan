//
//  DatabaseValueCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class DatabaseValueCell: NSTableCellView {
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: NSTextField!
    
    //
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //
    // MARK: - Public
    func configureCell(with field: Field, column: Column) {
        
        // Show raw data
        self.titleLbl.stringValue = field.rawData
        
        // Layout
        self.setupLayout(with: column)
    }
}

//
// MARK: - Private
extension DatabaseValueCell {
    
    fileprivate func setupLayout(with column: Column) {
        self.titleLbl.alignment = column.textAlignment
    }
}
