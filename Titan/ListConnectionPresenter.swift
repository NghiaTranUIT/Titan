//
//  ListConnectionPresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

protocol ListConnectionPresenterOutput: class {
    func didSelectedDatabase(_ databaseObj: DatabaseObj)
    func handleError(_ error: NSError)
    func reloadData()
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
}

