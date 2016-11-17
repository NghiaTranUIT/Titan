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
        self.fetchConnectionWorker.fetch {[unowned self] (dbs) in
            self.output.presentConnections(dbs)
        }
    }
    
    func selectConnection(action: SelectConnectionAction) {
        self.selecteConnectionWorker = SelectConnectionWorker(action: action)
        self.selecteConnectionWorker.fetch()
    }
}
