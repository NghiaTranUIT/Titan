//
//  TitanTableColumn.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class TitanTableColumn: NSTableColumn {

    //
    // MARK: - Variable
    var column: Column!
    
    //
    // MARK: - Init
    init(column: Column) {
        super.init(identifier: column.colName)
        self.column = column
        self.defaultData()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
// MARK: - Private
extension TitanTableColumn {
    fileprivate func defaultData() {
        self.width      = 50
        self.minWidth   = 200
        self.maxWidth   = 500
        self.isEditable = false
        self.headerCell.title = self.column.colName
        self.headerCell.alignment = .left
        self.headerCell.lineBreakMode = .byTruncatingMiddle
        self.resizingMask = .autoresizingMask
    }
}
