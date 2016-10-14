//
//  ListConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ListConnectionsViewController: BaseViewController {

    //
    // MARK: - Variable
    private let dataSource = ListConnectionDataSource(store: mainStore)
    
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // 1. Load connections in store 
        self.dataSource.loadConnection()
    }
    
    override func initCommon() {
        
        // Setup delegate 
        self.dataSource.delegate = self
        
        // Table View
        self.tableView.register(ConnectionCell.xib()!, forIdentifier: ConnectionCell.viewID)
        self.tableView.delegate = self.dataSource
        self.tableView.dataSource = self.dataSource
    }
}

//
// MARK: - Data source delegate
extension ListConnectionsViewController: ListConnectionDataSourceDelegate {
    func ListConnectionDataSourceChanged() {
        
    }
}
