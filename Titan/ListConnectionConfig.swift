//
//  ListConnectionConfig.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class ListConnectionConfig {

    static let shared = ListConnectionConfig()
    
    func configure(viewController: ListConnectionsController) {
        
        // Presenter
        let presenter = ListConnectionPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = ListConnectionInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
        viewController.dataSource = presenter
    }
}
