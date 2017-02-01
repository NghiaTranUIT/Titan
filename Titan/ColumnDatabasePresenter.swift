//
//  ColumnDatabasePresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ColumnDatabasePresenterOutput: class {
    
}

class ColumnDatabasePresenter {

    //
    // MARK: - Variable
    weak var output: ColumnDatabasePresenterOutput?
}

//
// MARK: - ColumnDatabaseInteractorOutput
extension ColumnDatabasePresenter: ColumnDatabaseInteractorOutput {
    
}
