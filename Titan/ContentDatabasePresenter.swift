//
//  DataDatabasePresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ContentDatabasePresenterOutput: class {
    
}

class ContentDatabasePresenter {
    
    //
    // MARK: - Variable
    weak var output: ContentDatabasePresenterOutput?
}

//
// MARK: - ContentDatabaseInteractorOutput
extension ContentDatabasePresenter: ContentDatabaseInteractorOutput {
    
}
