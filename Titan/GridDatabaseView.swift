//
//  GridDatabaseView.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class GridDatabaseView: NSView {

    //
    // MARK: - Variable
    var table: Table!
    fileprivate lazy var dataSource: GridDatabaseDataSource = self.initGridDatabaseDataSource()
    fileprivate var databaseContent: DatabaseContent?
    @IBOutlet weak var titleLbl: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        
        // Data source
        self.dataSource.tableView = self.tableView
    }
    
    //
    // MARK: - Public
    func configureGrid(with table: Table) {
        self.table = table
        self.titleLbl.stringValue = table.tableName!
        
        // Setup
        if self.databaseContent == nil {
            self.databaseContent = DatabaseContent(table: table)
        }
        
        // Fetch first page
        self.databaseContent!.firstPage()
    }
}

//
// MARK: - XIBInitializable
extension GridDatabaseView: XIBInitializable {
    typealias T = GridDatabaseView
}

//
// MARK: - Private
extension GridDatabaseView {
    
    // Init Data source {
    fileprivate func initGridDatabaseDataSource() -> GridDatabaseDataSource {
        let dataSource = GridDatabaseDataSource()
        return dataSource
    }
}
