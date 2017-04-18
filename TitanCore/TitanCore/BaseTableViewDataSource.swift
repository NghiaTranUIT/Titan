//
//  BaseTableViewDataSource.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

open class BaseTableViewDataSource: NSObject {

    //
    // MARK: - Variable
    public weak var delegate: BaseTableViewDataSourceProtocol?
    fileprivate var tableView: NSTableView!
    
    //
    // MARK: - Initialization
    public init(tableView: NSTableView) {
        super.init()
        
        self.tableView = tableView
        self.initTableView()
    }
}

//
// MARK: - Private
extension BaseTableViewDataSource {
    
    fileprivate func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

//
// MARK: - Table View
extension BaseTableViewDataSource: NSTableViewDataSource {
    
    public func numberOfRows(in tableView: NSTableView) -> Int {
        guard let delegate = self.delegate else {
            return 0;
        }
        
        return delegate.CommonDataSourceNumberOfItem(at: 0)
    }
    
}

//
// MARK: - Delegate TableView
extension BaseTableViewDataSource: NSTableViewDelegate {
    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let delegate = self.delegate else {
            return nil
        }
        
        return delegate.CommonDataSourceViewFor(tableColumn, row: row)
    }
    
    public func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        guard let delegate = self.delegate else {
            return nil
        }
        
        return delegate.CommonDataSourceRowView(for: row)
    }
    
    public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let delegate = self.delegate else {
            return 44.0
        }
        
        return delegate.CommonDataSourceHeight(for: row)
    }

}
