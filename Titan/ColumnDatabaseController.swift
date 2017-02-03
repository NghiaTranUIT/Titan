//
//  ColumnDatabaseController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ColumnDatabaseControllerOutput {
    func fetchColumnDatabaseInfo()
}

class ColumnDatabaseController: NSViewController {

    //
    // MARK: - Variable
    var output: ColumnDatabaseControllerOutput?
    fileprivate lazy var dataSource: ColumnsDataSource = self.initDataSource()
    
    //
    // MARK: - OUTLET
    
    
    //
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        ColumnDatabaseConfig.shared.configure(viewController: self)
    }
    
    override func initActions() {
        
        // Fetch column info
        self.output?.fetchColumnDatabaseInfo()
    }
}

//
// MARK: - ColumnDatabasePresenterOutput
extension ColumnDatabaseController: ColumnDatabasePresenterOutput {
    
}

//
// MARK: - Private
extension ColumnDatabaseController {
    
    // Init data source
    fileprivate func initDataSource() -> ColumnsDataSource {
        let data = ColumnsDataSource()
        return data
    }
}
