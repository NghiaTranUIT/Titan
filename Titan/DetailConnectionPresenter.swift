//
//  DetailConnectionPresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol DetailConnectionPresenterOutput: class {
    func presentError(with error: NSError)
}

class DetailConnectionPresenter {
    
    //
    // MARK: - Variable
    weak var output: DetailConnectionPresenterOutput?
}

//
// MARK: - DetailConnectionInteractorOutput
extension DetailConnectionPresenter: DetailConnectionInteractorOutput {
    
    func presentMainAppWithConnection(_ connection: DatabaseObj) {
        // Call Router Manager here
    }
    
    func presentError(with error: NSError) {
        self.output?.presentError(with: error)
    }
}
