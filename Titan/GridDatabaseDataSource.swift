
//
//  GridDatabaseDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 2/6/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import Cocoa

class GridDatabaseDataSource: NSObject {
    
    //
    // MARK: - Variable
    var tableView: NSTableView! {didSet{self.setupTable()}}
}

//
// MARK: - Private
extension GridDatabaseDataSource {

    fileprivate func setupTable() {
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
    }
}

//
// MARK: - NSTableViewDataSource
extension GridDatabaseDataSource: NSTableViewDataSource {

}

//
// MARK: - NSTableViewDelegate
extension GridDatabaseDataSource: NSTableViewDelegate {
    
}
