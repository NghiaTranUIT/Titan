//
//  DatabaseContent.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import TitanKit
import PromiseKit

class DatabaseContent: NSObject {
    
    //
    // MARK: - Variable
    fileprivate var workerQueue: Queue<BaseAsyncWorker> = Queue<BaseAsyncWorker>()
    fileprivate var mode = GridContentViewMode.none
    fileprivate var currentQuery: PostgreQuery?
    fileprivate let pagination = Pagination()
    var tableView: NSTableView! {didSet{self.setupTable()}}
    
    // Data
    fileprivate var rows: [Row] = []
    
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
            self.rows = queryResult.rows
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
        
        // Make col alwasy fit tableView's width
        self.tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.tableView.sizeLastColumnToFit()
        
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
        let cell = tableView.make(withIdentifier: DatabaseValueCell.identifierView, owner: nil) as! DatabaseValueCell
        
        let row = self.rows[row]
        let field = row.field(with: "id")!
        cell.configureCell(with: field)
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.make(withIdentifier: TableRowView.identifierView, owner: self) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView()
            rowView?.identifier = TableRowView.identifierView
        }
        
        return rowView
    }
}

//
// MARK: - NSTableViewDelegate
extension DatabaseContent: NSTableViewDelegate {
    
}

