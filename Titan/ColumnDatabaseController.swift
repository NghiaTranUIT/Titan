//
//  ColumnDatabaseController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ColumnDatabaseControllerOutput {
    
}

class ColumnDatabaseController: NSViewController {

    //
    // MARK: - Variable
    var output: ColumnDatabaseControllerOutput?
    
    //
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    override func initCommon() {
        
    }
    
    
}

//
// MARK: - ColumnDatabasePresenterOutput
extension ColumnDatabaseController: ColumnDatabasePresenterOutput {
    
}
