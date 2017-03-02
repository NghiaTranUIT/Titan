//
//  DatabaseContent.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import PromiseKit
import Cocoa

class DatabaseContent: NSObject {
    
    //
    // MARK: - Variable
    fileprivate var workerQueue: Queue<BaseAsyncWorker> = Queue<BaseAsyncWorker>()
    fileprivate var mode = GridContentViewMode.none
    fileprivate var currentQuery: PostgreQuery?
    fileprivate let pagination = Pagination()
    var tableView: NSTableView! {didSet{self.setupTable()}}
    
    // Data
    fileprivate var queryResult: QueryResult? {didSet {self.processColumnType()}}
    fileprivate var rows: [Row] {
        guard let result = self.queryResult else {
            return []
        }
        return result.rows
    }
    fileprivate var columns: [Column] {
        guard let result = self.queryResult else {
            return []
        }
        return result.columns
    }
    
    //
    // MARK: - Initializer
    
    //
    // MARK: - Public
    func configure(with mode: GridContentViewMode) {
        
        self.mode = mode
        
        switch self.mode {
        case .individually(let table):
            self.currentQuery = PostgreQuery.buildDefaultQuery(with: table, pagination: self.pagination)
            break
        case .dynamic:
            break
        case .none:
            break
        }
    }
    
    func query(_ query: PostgreQuery) {
        
    }
    
    func fetchFirstPage() {
        
        // Cancel
        self.cancelAllWorker()
        
        // Fetch
        DatabaseManager.shared.fetchQuery(self.currentQuery!)
        .then {[weak self] queryResult -> Void in
            
            guard let `self` = self else {return}
            
            // Update
            self.queryResult = queryResult
            self.tableView.reloadData()
        }
        .catch { error in
            
        }
    }
    
    //
    // MARK: - Pagination
    func nextPage() {
        
        // Cancel
        self.cancelAllWorker()
        
    }
    
    func previousPage() {
        
        // Cancel
        self.cancelAllWorker()
        
    }
}

//
// MARK: - Private
extension DatabaseContent {
    
    fileprivate func cancelAllWorker() {
        
    }
    
    fileprivate func processColumnType() {
        
        // Remove all first
        self.tableView.removeAllColumns()
        
        let cols = self.columns.map { column -> NSTableColumn in
            return TitanTableColumn(column: column)
        }
        
        for col in cols {
            self.tableView.addTableColumn(col)
        }
    
    }
}

//
// MARK: - Private
extension DatabaseContent {
    
    fileprivate func setupTable() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        // Register
        self.tableView.registerView(PlaceholderTableCell.self)
        self.tableView.registerView(DatabaseValueCell.self)
        
        // Reload
        self.tableView.reloadData()
    }
}

//
// MARK: - NSTableViewDataSource
extension DatabaseContent: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.rows.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumn = tableColumn as? TitanTableColumn else {return nil}

        let cell = tableView.make(withIdentifier: DatabaseValueCell.identifierView, owner: nil) as! DatabaseValueCell
        
         print("\(row) \(tableColumn.column!.colName)")
        
        // Get col
        let col = tableColumn.column!
        let row = self.rows[row]
        let field = row.field(with: col)!
        cell.configureCell(with: field, column: col)
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.make(withIdentifier: ContentRowView.identifierView, owner: self) as? ContentRowView
        
        if rowView == nil {
            rowView = ContentRowView()
            rowView?.identifier = ContentRowView.identifierView
        }
        
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}

//
// MARK: - NSTableViewDelegate
extension DatabaseContent: NSTableViewDelegate {
    
}

