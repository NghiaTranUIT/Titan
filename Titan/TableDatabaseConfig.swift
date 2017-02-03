//
//  ColumnDatabaseConfig.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class TableDatabaseConfig {
    
    static let shared = TableDatabaseConfig()
    
    func configure(viewController: TableDatabaseController) {
        
        // Presenter
        let presenter = TableDatabasePresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = TableDatabaseInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}
