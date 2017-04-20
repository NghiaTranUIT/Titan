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
    
    func CommonDataSourceNumberOfItem(at section: Int) -> Int {
        return self.viewModel.output.tablesVariable.value.count
    }
    
    // Number of section
    func CommonDataSourceNumberOfSection() -> Int {
        return 1
    }
    
    // Item at index path
    func CommonDataSourceItem(at indexPath: IndexPath) -> Any {
        return self.viewModel.output.tablesVariable.value[indexPath.item]
    }
    
    // Height for row
    func CommonDataSourceHeight(for row: Int) -> CGFloat {
        return 26.0
    }
    
    // didSelect
    func CommonDataSourceDidSelectedRow(at indexPath: IndexPath) {
        
    }
}
