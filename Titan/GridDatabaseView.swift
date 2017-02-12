//
//  GridDatabaseView.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

enum GridContentViewMode {
    case individually(Table)
    case dynamic
    case none
}

class GridDatabaseView: NSView {

    //
    // MARK: - Variable
    fileprivate lazy var dataSource: GridDatabaseDataSource = self.initGridDatabaseDataSource()
    fileprivate var databaseContent = DatabaseContent()
    fileprivate var mode: GridContentViewMode = .none
    var table: Table? {
        switch self.mode {
        case .individually(let table):
            return table
        default:
            return nil
        }
    }
    
    //
    // MARK: - OUTLET
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
    func configureGridDatabase(with mode: GridContentViewMode) {
        
        self.mode = mode
        
        // Content
        self.databaseContent.configure(with: mode)
        
        // Fetch first page
        self.databaseContent.fetchFirstPage()
    }
    
    func query(_ query: PostgreQuery) {
        
        // Fetch data with new query
        self.databaseContent.query(query)
        
        // First page
        self.databaseContent.fetchFirstPage()
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
