//
//  TitanTableColumn.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

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
        self.minWidth   = 100
        self.maxWidth   = 500
        self.isEditable = false
        self.headerCell.title = self.column.colName
        self.headerCell.alignment = .left
        self.headerCell.lineBreakMode = .byTruncatingMiddle
        self.resizingMask = .userResizingMask
        
        // Hack to estimate width of column depend on title.
        // TODO: - Width should be width of cell which largest content
        self.width      = self.headerCell.cellSize.width + 8
    }
}
