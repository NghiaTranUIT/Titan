//
//  DataDatabaseConfig.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ContentDatabaseConfig {

    static let shared = ContentDatabaseConfig()
    
    func configure(viewController: ContentDatabaseController) {
        
        // Presenter
        let presenter = ContentDatabasePresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = ContentDatabaseInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
}
