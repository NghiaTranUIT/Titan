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
    fileprivate var groupConnections: Variable<[GroupConnectionObj]> {
        return mainStore.state.connectionState!.groupConnections
    }
    
    /// Obserable
    fileprivate func initCommon() {
        self.groupConnections.asObservable().subscribe { (dbs) in
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
    func numberOfGroupConnections() -> Int {
        return self.groupConnections.value.count
    }
    
    func numberOfDatabase(at section: Int) -> Int {
        return self.groupConnections.value[section].connections.count
    }
    
    func groupConnection(at indexPath: IndexPath) -> GroupConnectionObj {
        return self.groupConnections.value[indexPath.section]
    }
    
    func database(at indexPath: IndexPath) -> DatabaseObj {
        return self.groupConnections.value[indexPath.section].connections[indexPath.item]
    }

}
