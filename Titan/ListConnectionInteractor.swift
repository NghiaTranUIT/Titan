//
//  ListConnectionInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ListConnectionInteractorInput: ListConnectionsControllerOutput {
    
}

protocol ListConnectionInteractorOutput {
    func presentConnections(_ connections: [DatabaseObj])
    func presentError(_ error: NSError)
}


class ListConnectionInteractor {
    
    //
    // MARK: - Variable
    var output: ListConnectionInteractorOutput!
    
    
    //
    // MARK: - Worker
    fileprivate var fetchConnectionWorker: FetchConnectionsWorker!
    fileprivate var selecteConnectionWorker: SelectConnectionWorker!
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionInteractorInput {
    
    func fetchConnections(action: FetchConnectionsAction) {
        self.fetchConnectionWorker = FetchConnectionsWorker(action: action)
        self.fetchConnectionWorker.execute {[unowned self] (result) in
            switch result {
            case .Success(let dbs as [DatabaseObj]):
                self.output.presentConnections(dbs)
            case .Failure(let error):
                self.output.presentError(error as NSError)
            default:
                break
            }
        }
    }
    
    func selectConnection(action: SelectConnectionAction) {
        self.selecteConnectionWorker = SelectConnectionWorker(action: action)
        self.selecteConnectionWorker.execute()
    }
}
