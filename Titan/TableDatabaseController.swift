//
//  ColumnDatabaseController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import TitanKit

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
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var searchBarView: NSView!
    @IBOutlet weak var tableView: NSTableView!
    
    //
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        TableDatabaseConfig.shared.configure(viewController: self)
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
}

extension TableDatabaseController: TablesDataSourceDelegate {
    func TablesDataSourceDidSelectTable(_ table: Table) {
        self.output?.didSelectTable(table)
    }
    
    func TablesDataSourceDidDoubleTapOnTable(_ table: Table) {
        self.output?.didDoubleTapTable(table)
    }
}
