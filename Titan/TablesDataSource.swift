//
//  ColumnsDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

protocol TablesDataSourceDelegate: class {
    func TablesDataSourceDidSelectTable(_ table: Table)
    func TablesDataSourceDidDoubleTapOnTable(_ table: Table)
}

class TablesDataSource: NSObject {
    
    //
    // MARK: - Variable
    weak var delegate: TablesDataSourceDelegate?
    fileprivate var isFirstTime = true
    var tableView: NSTableView! {didSet{self.setupTableView()}}
    fileprivate var tables: [Table] {
        return mainStore.state.detailDatabaseState!.tables
    }
    
    //
    // MARK: - Init
    override init() {
        super.init()
        self.initCommon()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    /// Obserable
    fileprivate func initCommon() {
        NotificationManager.observeNotificationType(.tableStateChanged, observer: self, selector: #selector(self.tableStateChanged), object: nil)
    }
    
    //
    // MARK: - Public
    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Register
        self.tableView.registerView(PlaceholderTableCell.self)
        self.tableView.registerView(TableRowCell.self)
        
        // Make col alwasy fit tableView's width
        self.tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.tableView.sizeLastColumnToFit()
        
        // Reload
        self.tableView.reloadData()
    }
    
    @objc func tableStateChanged() {
        self.tableView.reloadData()
    }
    
    @objc func doubleTapAction() {
        guard self.tableView.selectedRow >= 0 else {return}
        
        let table = self.tables[self.tableView.selectedRow]
        self.delegate?.TablesDataSourceDidDoubleTapOnTable(table)
    }
}

extension TablesDataSource: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        // placeholderCell cell
        if self.tables.count == 0 {
            return 1
        }
        
        return self.tables.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if self.tables.count == 0 {
            return self.placeholderCell(with: tableView, row: row)
        }
        
        return self.tableCell(with: tableView, row: row)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 26
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

extension TablesDataSource: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        guard self.tables.count > 0 else {return false}
        
        let table = self.tables[row]
        self.delegate?.TablesDataSourceDidSelectTable(table)
        return true
    }
    
}

//
// MARK: - Private
extension TablesDataSource {
    
    fileprivate func placeholderCell(with tableView: NSTableView, row: Int) -> PlaceholderTableCell {
        let cell = tableView.make(withIdentifier: PlaceholderTableCell.identifierView, owner: self) as! PlaceholderTableCell
        cell.configurePlaceholderCell(with: "No tables", isShowLoader: self.isFirstTime)
        return cell
    }
    
    fileprivate func tableCell(with tableView: NSTableView, row: Int) -> TableRowCell {
        let cell = tableView.make(withIdentifier: TableRowCell.identifierView, owner: self) as! TableRowCell
        let table = self.tables[row]
        cell.configureCell(with: table)
        return cell
    }
}
