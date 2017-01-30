//
//  ListConnectionPresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ListConnectionPresenterOutput: class {
    func handleError(_ error: NSError)
    func shouldSelectCellWithDatabase(_ databaseObj: DatabaseObj)
}


class ListConnectionPresenter {

    //
    // MARK: - Variable
    weak var output: ListConnectionPresenterOutput?
}


//
// MARK: - ListConnectionInteractorOutput
extension ListConnectionPresenter: ListConnectionInteractorOutput {
    
    func presentError(_ error: NSError) {
        self.output?.handleError(error)
    }
    
    func shouldSelectCellWithDatabase(_ databaseObj: DatabaseObj) {
        self.output?.shouldSelectCellWithDatabase(databaseObj)
    }
}

