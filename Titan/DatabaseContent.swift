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

protocol DatabaseContentDelegate: class {
    func DatabaseContentDidUpdatedQueryResult(_ queryResult: QueryResult)
    func DatabaseContentDidSelectionChanged(_ selectedRowIndexes: IndexSet, rowAffect: Int)
}

let NOT_A_ROW = -1

class DatabaseContent: NSObject {
    
    //
    // MARK: - Variable
    weak var delegate: DatabaseContentDelegate?
    fileprivate var workerQueue: Queue<BaseAsyncWorker> = Queue<BaseAsyncWorker>()
    fileprivate var mode = GridContentViewMode.none
    fileprivate var currentQuery: PostgreQuery?
    fileprivate let pagination = Pagination()
    var tableView: NSTableView! {didSet{self.setupTable()}}
    
    // Data
    fileprivate var queryResult: QueryResult? {didSet {
        self.delegate?.DatabaseContentDidUpdatedQueryResult(queryResult!)
        self.processColumnType()
    }}
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
    var numberRowEffect: Int {
        guard let queryResult = self.queryResult else {return 0}
        return queryResult.rowsAffected
    }
    func field(at col: Column, row: Int) -> Field {
        let row = self.rows[row]
        let field = row.field(with: col)!
        return field
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
    
    func userDoubleClicked(_ sender: NSTableView) {
        
        // Don't allow multi
        guard sender.selectedRowIndexes.count == 1 else {return}
        
        let row = sender.clickedRow
        let col = sender.clickedColumn
        
        // Not a row
        guard row != NOT_A_ROW else {return}
        guard let cell = sender.view(atColumn: col, row: row, makeIfNecessary: true) as? TextFieldCellView else {return}
        
        // Edit TextField
        let _ = cell.becomeFirstResponder()
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
        
        let tableCellType = tableColumn.tableViewCellType
        switch tableCellType {
        case .switchButton:
            return self.switchCellCell(tableColumn: tableColumn, row: row)
            
        case .textField:
            return self.textFieldCellView(tableColumn: tableColumn, row: row)
            
        }
        
        // Get col

//        cell.configureCell(with: field, column: col)
//        
//        return cell
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
    
    private func switchCellCell(tableColumn: TitanTableColumn, row: Int) -> BoolCellView {
        var cell = self.tableView.make(withIdentifier: tableColumn.identifier, owner: self) as? BoolCellView
        if cell == nil {
            cell = BoolCellView.viewWithIdentifier(tableColumn.identifier)
        }
        
        cell!.configureCell()
        return cell!
    }
    
    private func textFieldCellView(tableColumn: TitanTableColumn, row: Int) -> TextFieldCellView {
        var cell = self.tableView.make(withIdentifier: tableColumn.identifier, owner: self) as? TextFieldCellView
        if cell == nil {
            cell = TextFieldCellView.viewWithIdentifier(tableColumn.identifier)
        }
        
        // Configure
        let col = tableColumn.column!
        let field = self.field(at: col, row: row)
        cell!.configureCell(with: field, column: col)
        return cell!
    }
}

//
// MARK: - NSTableViewDelegate
extension DatabaseContent: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        // Update status bar
        let set = self.tableView.selectedRowIndexes
        self.delegate?.DatabaseContentDidSelectionChanged(set, rowAffect: self.numberRowEffect)
    }
}

