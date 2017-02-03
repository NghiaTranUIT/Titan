//
//  ColumnDatabaseController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol TableDatabaseControllerOutput {
    func fetchTablesDatabaseInfo()
}

class TableDatabaseController: NSViewController {

    //
    // MARK: - Variable
    var output: TableDatabaseControllerOutput?
    fileprivate lazy var dataSource: TablesDataSource = self.initDataSource()
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var searchBarView: NSView!
    @IBOutlet weak var collectionView: NSCollectionView!
    
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
        data.collectionView = self.collectionView
        return data
    }
}
