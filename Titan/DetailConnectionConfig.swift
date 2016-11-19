//
//  DetailConnectionConfig.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class DetailConnectionConfig {

    static let shared = DetailConnectionConfig()
    
    func configure(viewController: DetailConnectionsController) {
        
        // Presenter
        let presenter = DetailConnectionPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = DetailConnectionInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
        viewController.dataSource = presenter
    }
    
}
