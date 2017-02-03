//
//  ColumnDatabasePresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol TableDatabasePresenterOutput: class {
    
}

class TableDatabasePresenter {

    //
    // MARK: - Variable
    weak var output: TableDatabasePresenterOutput?
}

//
// MARK: - ColumnDatabaseInteractorOutput
extension TableDatabasePresenter: TableDatabaseInteractorOutput {
    
}
