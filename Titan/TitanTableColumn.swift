//
//  TitanTableColumn.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

enum TableViewCellType {
    case textField
    case switchButton
}

class TitanTableColumn: NSTableColumn {

    //
    // MARK: - Variable
    fileprivate static let DefaultColumnWidth: CGFloat = 100.0
    fileprivate static let MaxColumnWidth: CGFloat = 200.0
    
    var column: Column!
    var tableViewCellType: TableViewCellType {
        switch self.column.colType {
        case .boolean:
            return TableViewCellType.switchButton
        default:
            return TableViewCellType.textField
        }
    }
    
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
    
    
    /// Calculate size that fit the contents
    ///
    /// - Parameter limit: <#limit description#>
    func sizeThatFits(limit: Bool) -> CGFloat {
        guard let tableView = self.tableView else {return TitanTableColumn.DefaultColumnWidth}
        
        let rowsToConsider = self.numberRowsConsider
        let columnIndex = tableView.tableColumns.index(of: self) ?? 0
        
        // Reload if need
        if tableView.numberOfRows == 0  {
            tableView.reloadData()
        }
        
        // Get maxWidth
        var maxWidth: CGFloat = 0
        let rowInterate = min(rowsToConsider, tableView.numberOfRows)
        for rowIndex in 0..<rowInterate {
            if let tableCellView = tableView.view(atColumn: columnIndex, row: rowIndex, makeIfNecessary: true) {
                maxWidth = max(maxWidth, tableCellView.fittingSize.width)
            }
        }
        
        let rect = NSRect(x: 0, y: 0, width: CGFloat.infinity, height: tableView.rowHeight)
        let headerSize = self.headerCell.cellSize(forBounds: rect)
        
        maxWidth = max(maxWidth + 10, headerSize.width * 1.1)
        
        if limit {
            maxWidth = min(maxWidth, TitanTableColumn.MaxColumnWidth)
        }
        
        return maxWidth + 8 // + padding
    }
    
}

//
// MARK: - Private
extension TitanTableColumn {
    
    
    /// Init Default data for columns
    fileprivate func defaultData() {
        self.minWidth   = 50
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
    
    
    /// Get optimazation rows should consider to compute fit size
    fileprivate var numberRowsConsider: Int {
        switch self.column.colType {
        case .jsonArray:
            fallthrough
        case .charArray:
            fallthrough
        case .intArray:
            return 5
        
        case .json:
            fallthrough
        case .varchar:
            return 10
            
        default:
            return 1
        }
    }
}
