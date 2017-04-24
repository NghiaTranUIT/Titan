//
//  TableListDatabaseSource.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import TitanCore
import SwiftyPostgreSQL

class TableListDatabaseSource: BaseTableViewDataSource {
    
    //
    // MARK: - Variable
    fileprivate lazy var rightMenuContextView: TableSchemeContextMenuView = self.initMenuContextView()
    
    //
    // MARK: - Init
    override init(tableView: TitanTableView) {
        super.init(tableView: tableView)
        
        self.initTableView()
    }

    //
    // MARK: - Override
    override func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let count = self.delegate!.CommonDataSourceNumberOfItem(at: 0)
        
        if count == 0 {
            return self.placeholderCell(with: tableView, row: row)
        }
        
        return self.tableCell(with: tableView, row: row)
    }
    
    override func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.make(withIdentifier: TableRowView.identifierView, owner: self) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView()
            rowView?.identifier = TableRowView.identifierView
        }
        
        return rowView
    }

}

//
// MARK: - Private
extension TableListDatabaseSource {
    
    fileprivate func initTableView() {
        
        // Register
        self.tableView.registerView(TableRowCell.self, bundleType: BundleType.core)
        self.tableView.registerView(PlaceholderCell.self)
        
        // Make col alwasy fit tableView's width
        self.tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.tableView.sizeLastColumnToFit()
        
        // Context menu
        self.tableView.contextMenuDelegate = self
        
        // Reload
        self.tableView.reloadData()
    }
    
    // Menu context
    fileprivate func initMenuContextView() -> TableSchemeContextMenuView {
        let contextView = TableSchemeContextMenuView.viewFromNib(with: .core)!
        contextView.contextDelegate = self
        contextView.delegate = self
        return contextView
    }
    
    fileprivate func placeholderCell(with tableView: NSTableView, row: Int) -> PlaceholderCell {
        let cell = tableView.make(withIdentifier: PlaceholderCell.identifierView, owner: self) as! PlaceholderCell
        cell.configurePlaceholderCell(with: "No tables", isShowLoader: true)
        return cell
    }
    
    fileprivate func tableCell(with tableView: NSTableView, row: Int) -> TableRowCell {
        let cell = tableView.make(withIdentifier: TableRowCell.identifierView, owner: self) as! TableRowCell
        
        let table = self.delegate!.CommonDataSourceItem(at: IndexPath(item: row, section: 0)) as! Table
        cell.configureCell(with: table)
        
        return cell
    }
}

//
// MARK: - TableSchemeContextMenuViewDelegate
extension TableListDatabaseSource: TableSchemeContextMenuViewDelegate {
    
    func TableSchemeContextMenuViewDidTapAction(_ action: TableSchemmaContextAction, table: Table) {
        
    }
}


extension TableListDatabaseSource: NSMenuDelegate {
    func menuDidClose(_ menu: NSMenu) {
        guard let menu = menu as? TableSchemeContextMenuView else {return}
        
        // Reset state
        menu.selectedRow?.updateRightClickState(isHover: false)
    }
}


//
// MARK: - ContextMenuTableViewDelegate
extension TableListDatabaseSource: ContextMenuTableViewDelegate {
    
    func customContexMenuView(for event: NSEvent) -> NSMenu? {
        
        let pt = self.tableView.convert(event.locationInWindow, from: nil)
        let selectedRowIndex = self.tableView.row(at: pt)
        guard selectedRowIndex >= 0 else {return nil}
        guard let selectedRow = self.tableView.rowView(atRow: selectedRowIndex, makeIfNecessary: true)?
            .view(atColumn: 0) as? TableRowCell else {return nil}
        
        // Update
        selectedRow.updateRightClickState()
        let seletedTable = self.delegate!.CommonDataSourceItem(at: IndexPath(item: selectedRowIndex, section: 0)) as! Table
        self.rightMenuContextView.configureContextView(with: seletedTable, selectedRow: selectedRow)
        return self.rightMenuContextView
    }
}
