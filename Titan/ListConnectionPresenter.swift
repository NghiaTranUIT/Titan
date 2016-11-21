//
//  ListConnectionPresenter.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

protocol ListConnectionPresenterInput: ListConnectionInteractorOutput {
    
}

class ListConnectionPresenter {

    //
    // MARK: - Variable
    weak var output: ListConnectionsControllerInput! {
        didSet {
            self.initCommon()
        }
    }
    private let disposeBad = DisposeBag()
    fileprivate var connections: Variable<[DatabaseObj]> {
        return mainStore.state.connectionState!.connections
    }
    
    /// Obserable
    fileprivate func initCommon() {
        self.connections.asObservable().subscribe { (dbs) in
            self.output.reloadData()
        }
        .addDisposableTo(self.disposeBad)
    }
}

//
// MARK: - ListConnectionPresenterInput
extension ListConnectionPresenter: ListConnectionPresenterInput {
    
    func presentError(_ error: NSError) {
        
    }

}

//
// MARK: - ListConnectionsControllerDataSource
extension ListConnectionPresenter: ListConnectionsControllerDataSource {
    func numberOfConnections() -> Int {
        return self.connections.value.count
    }
    
    func connection(at row: Int) -> DatabaseObj {
        return self.connections.value[row]
    }
}
