//
//  TitanTableView.swift
//  Titan
//
//  Created by Nghia Tran on 2/5/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol ContextMenuTableViewDelegate: class {
    
    // Provide custom Context Menu View
    func customContexMenuView(for event: NSEvent) -> NSMenu?
}

class TitanTableView: NSTableView {

    //
    // MARK: - Variable
    weak var contextMenuDelegate: ContextMenuTableViewDelegate?
    
    //
    // MARK: - View Cycle
    
    
    /// Provide context menu
    ///
    /// - Parameter event: Event context
    /// - Returns: Context Menu
    override func menu(for event: NSEvent) -> NSMenu? {
        
        // Provide custom context
        if let menu = self.contextMenuDelegate?.customContexMenuView(for: event) {
            return menu
        }
        
        return super.menu(for: event)
    }
    
    //
    // MARK: - Public
    
    
    /// Remove all columns
    func removeAllColumns() {
        while self.tableColumns.count > 0 {
            let tableColumn = self.tableColumns.last
            self.removeTableColumn(tableColumn!)
        }
    }
    
    /// Setup NSTableView with columns
    ///
    /// - Parameter columns: Array of col from SwifyPostgreSQL
    func setupColumns(_ columns: [Column]) {
        
        // Remove all first
        self.removeAllColumns()
        self.reloadData()
        
        // Map to TitanTableColumn
        let cols = columns.map { column -> TitanTableColumn in
            return TitanTableColumn(column: column)
        }
        
        self.beginUpdates()
        for col in cols {
            self.addTableColumn(col)
        }
        self.endUpdates()
        
        // FIXME: force layout subview to change header view height
        self.enclosingScrollView?.tile()
    }
    
    func makeColumnsFitContents() {
        
        // Interate each columns and fit it
        for column in self.tableColumns as! [TitanTableColumn] {
            column.width = column.sizeThatFits(limit: true)
        }
    }
}
