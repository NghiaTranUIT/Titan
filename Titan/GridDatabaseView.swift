//
//  GridDatabaseView.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

enum GridContentViewMode {
    case individually(Table)
    case dynamic
    case none
}

class GridDatabaseView: NSView {

    //
    // MARK: - Variable
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
    fileprivate var statusBarView: StatusBarView!
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var containerStatusBarView: NSView!
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        
        // Data source
        self.databaseContent.delegate = self
        self.databaseContent.tableView = self.tableView
        
        // Status bar
        self.initStatusBarView()
        
        // Double tap 
        self.tableView.target = self
        self.tableView.doubleAction = #selector(self.userDoubleClicked(_:))
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

    @objc fileprivate func userDoubleClicked(_ sender: NSTableView) {
        self.databaseContent.userDoubleClicked(sender)
    }
}

//
// MARK: - DatabaseContentDelegate
extension GridDatabaseView: DatabaseContentDelegate {
    
    func DatabaseContentDidUpdatedQueryResult(_ queryResult: QueryResult) {
        self.handleStatusBarView()
    }
}
//
// MARK: - Status Bar
extension GridDatabaseView {
    
    fileprivate func initStatusBarView() {
        self.statusBarView = StatusBarView.viewFromNib()
        self.statusBarView.configureLayoutWithView(self.containerStatusBarView)
    }
    
    func handleStatusBarView() {
        self.statusBarView.updateNumberOfRowAffected(self.databaseContent.numberRowEffect)
    }
}
