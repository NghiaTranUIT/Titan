//
//  DataDatabaseInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ContentDatabaseInteractorOutput {
    
}

class ContentDatabaseInteractor {

    //
    // MARK: - Variable
    var output: ContentDatabaseInteractorOutput?
}

//
// MARK: - ContentDatabaseControllerOutput
extension ContentDatabaseInteractor: ContentDatabaseControllerOutput {
    
}
