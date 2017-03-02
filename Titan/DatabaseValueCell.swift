//
//  DatabaseValueCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

class DatabaseValueCell: NSTableCellView {
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: NSTextField!
    
    //
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLbl.maximumNumberOfLines = 2
    }
    
    override func becomeFirstResponder() -> Bool {
        self.titleLbl.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    //
    // MARK: - Public
    func configureCell(with field: Field, column: Column) {
        
        // Show raw data
        if field.isNull {
            self.titleLbl.placeholderString = field.rawData
            self.titleLbl.stringValue = ""
        } else {
            self.titleLbl.stringValue = field.rawData
        }
        
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
