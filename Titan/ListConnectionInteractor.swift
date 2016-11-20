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
    func addNewConnection(_ connection: DatabaseObj)
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
    fileprivate var addNewConnectionWorker: CreateNewDefaultConnectionWorker!
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionInteractorInput {
    
    func addNewConnection() {
        let action = CreateNewDefaultConnectionAction()
        self.addNewConnectionWorker = CreateNewDefaultConnectionWorker(action: action)
        self.addNewConnectionWorker.execute().onSuccess { db in
            self.output.addNewConnection(db)
        }.onFailure { error in
            self.output.presentError(error as NSError)
        }
    }

    func fetchConnections() {
        let action = FetchConnectionsAction()
        self.fetchConnectionWorker = FetchConnectionsWorker(action: action)
        self.fetchConnectionWorker.execute().onSuccess { dbs in
            self.output.presentConnections(dbs)
        }
        .onFailure { error in
            self.output.presentError(error as NSError)
        }
    }
    
    func selectConnection(_ connection: DatabaseObj) {
        let action = SelectConnectionAction(selectedConnection: connection)
        self.selecteConnectionWorker = SelectConnectionWorker(action: action)
        self.selecteConnectionWorker.execute()
    }
}
