//
//  ColumnDatabaseController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

protocol TableDatabaseControllerOutput {
    func fetchTablesDatabaseInfo()
    func didSelectTable(_ table: Table)
    func didDoubleTapTable(_ table: Table)
}

class TableDatabaseController: NSViewController {

    //
    // MARK: - Variable
    var output: TableDatabaseControllerOutput?
    fileprivate var dataSource: TablesDataSource!
    fileprivate lazy var rightMenuContextView: TableSchemeContextMenuView = self.initMenuContextView()
    //
    // MARK: - OUTLET
    @IBOutlet weak var searchBarView: NSView!
    @IBOutlet weak var tableView: TitanTableView!
    
    //
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        TableDatabaseConfig.shared.configure(viewController: self)
        
        // Context menu
        self.tableView.contextMenuDelegate = self
    }
    
    override func initActions() {
        
        // Setup data source
        self.dataSource = self.initDataSource()
        
        // Fetch column info
        self.output?.fetchTablesDatabaseInfo()
    }
    
}

//
// MARK: - ColumnDatabasePresenterOutput
extension TableDatabaseController: TableDatabasePresenterOutput {
    
}

//
// MARK: - Private
extension TableDatabaseController {
    
    // Init data source
    fileprivate func initDataSource() -> TablesDataSource {
        let data = TablesDataSource()
        data.tableView = self.tableView
        data.delegate = self
        return data
    }
    
    // Menu context
    fileprivate func initMenuContextView() -> TableSchemeContextMenuView {
        let contextView = TableSchemeContextMenuView.viewFromNib()!
        contextView.contextDelegate = self
        contextView.delegate = self
        return contextView
    }
}

//
// MARK: - TablesDataSourceDelegate
extension TableDatabaseController: TablesDataSourceDelegate {
    func TablesDataSourceDidSelectTable(_ table: Table) {
        self.output?.didSelectTable(table)
    }
    
    func TablesDataSourceDidDoubleTapOnTable(_ table: Table) {
        self.output?.didDoubleTapTable(table)
    }
}

//
// MARK: - ContextMenuTableViewDelegate
extension TableDatabaseController: ContextMenuTableViewDelegate {
    
    func customContexMenuView(for event: NSEvent) -> NSMenu? {
        
        let pt = self.tableView.convert(event.locationInWindow, from: nil)
        let selectedRowIndex = self.tableView.row(at: pt)
        guard selectedRowIndex >= 0 else {return nil}
        guard let selectedRow = self.tableView.rowView(atRow: selectedRowIndex, makeIfNecessary: true)?
                                .view(atColumn: 0) as? TableRowCell else {return nil}
        
        // Update
        selectedRow.updateRightClickState()
        let seletedTable = self.dataSource.tableAtIndex(selectedRowIndex)
        self.rightMenuContextView.configureContextView(with: seletedTable, selectedRow: selectedRow)
        return self.rightMenuContextView
    }
}

//
// MARK: - TableSchemeContextMenuViewDelegate
extension TableDatabaseController: TableSchemeContextMenuViewDelegate {
    
    func TableSchemeContextMenuViewDidTapAction(_ action: TableSchemmaContextAction, table: Table) {
        self.output?.didDoubleTapTable(table)
    }
}

extension TableDatabaseController: NSMenuDelegate {
    func menuDidClose(_ menu: NSMenu) {
        guard let menu = menu as? TableSchemeContextMenuView else {return}
        
        // Reset state
        menu.selectedRow?.updateRightClickState(isHover: false)
    }
}
