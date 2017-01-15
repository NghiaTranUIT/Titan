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
    
    // List connection Data source
    fileprivate lazy var dataSource: ListConnectionDataSource = {
       let data = ListConnectionDataSource()
        data.delegate = self
        return data
    }()
    
}


//
// MARK: - ListConnectionInteractorOutput
extension ListConnectionPresenter: ListConnectionInteractorOutput {
    
    func presentError(_ error: NSError) {
        self.output?.handleError(error)
    }
}


//
// MARK: - Data Source
extension ListConnectionPresenter: ListConnectionsControllerDataSource {
    func dataSourceForListConnection() -> ListConnectionDataSource {
        return self.dataSource
    }
}

extension ListConnectionPresenter: ListConnectionDataSourceDelegate {
    func ListConnectionDataSourceDidSelectedDatabase(_ databaseObj: DatabaseObj) {
        self.output?.didSelectedDatabase(databaseObj)
    }
    
    func ListConnectionDataSourceReloadData() {
        self.output?.reloadData()
    }
}
