//
//  ListConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ListConnectionsController: BaseViewController {

    //
    // MARK: - Variable
    private lazy var viewModel = {return ListConnectionViewModel()}()
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // 1. Load connections 
        self.viewModel.fetchConnections()
    }
    
    override func initCommon() {
        
    }
    
}
