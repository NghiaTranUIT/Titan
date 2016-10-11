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
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override func initCommon() {
        
        // Setup delegate 
        self.dataSource.delegate = self
    }
    
}

//
// MARK: - Data source delegate
extension ListConnectionsViewController: ListConnectionDataSourceDelegate {
    func ListConnectionDataSourceChanged() {
        
    }
}
