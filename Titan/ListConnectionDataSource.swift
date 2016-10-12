//
//  ListConnectionDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

protocol ListConnectionDataSourceDelegate {
    func ListConnectionDataSourceChanged()
}

class ListConnectionDataSource: BaseDataSource {
    var delegate: ListConnectionDataSourceDelegate?
}

//
// MARK: - Public
extension ListConnectionDataSource {
    func loadConnection() {
        self.store.dispatch(GetConnectionFromDatabaseAction())
    }
}

//
// MARK: - Private
extension ListConnectionDataSource {
    private func loadConnectionFromDB() {
        
    }
    
    private func loadConnectionFromCloud() {
        
    }
}

extension ListConnectionDataSource: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }
    
    @objc(tableView:viewForTableColumn:row:)
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
    }
}

extension ListConnectionDataSource: NSTableViewDelegate {
    
}
