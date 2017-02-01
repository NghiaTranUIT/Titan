//
//  ColumnDatabaseConfig.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ColumnDatabaseConfig {
    
    static let shared = ColumnDatabaseConfig()
    
    func configure(viewController: ColumnDatabaseController) {
        
        // Presenter
        let presenter = ColumnDatabasePresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = ColumnDatabaseInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}
