//
//  TableListDatabaseController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class TableListDatabaseController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    
    
    //
    // MARK: - Variable
    fileprivate var viewModel: TableListViewModel!
    fileprivate var dataSource: TableListDatabaseSource!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initDataSource()
        self.initViewModel()
        self.binding()
    }
    
}

//
// MARK: - Private
extension TableListDatabaseController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
        self.dataSource = TableListDatabaseSource(tableView: self.tableView)
        self.dataSource.delegate = self
    }
    
    fileprivate func initViewModel() {
        self.viewModel = TableListViewModel()
    }
    
    fileprivate func binding() {
        
    }
}

//
// MARK: - BaseTableViewDataSourceProtocol
extension TableListDatabaseController: BaseTableViewDataSourceProtocol{
    
    func CommonDataSourceViewFor(_ tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
    }
    
    // Row view for row
    func CommonDataSourceRowView(for row: Int) -> NSTableRowView? {
        
    }
    
    // Height for row
    func CommonDataSourceHeight(for row: Int) -> CGFloat {
        
    }
    
    // didSelect
    func CommonDataSourceDidSelectedRow(at indexPath: IndexPath) {
        
    }
}
