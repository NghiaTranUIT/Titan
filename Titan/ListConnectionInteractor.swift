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
        self.addNewConnectionWorker.execute { (result) in
            switch result {
            case .Success(let db as DatabaseObj):
                self.output.addNewConnection(db)
            case .Failure(let error):
                self.output.presentError(error as NSError)
            default:
                break
            }
        }
    }

    func fetchConnections() {
        let action = FetchConnectionsAction()
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
    
    func selectConnection(_ connection: DatabaseObj) {
        let action = SelectConnectionAction(selectedConnection: connection)
        self.selecteConnectionWorker = SelectConnectionWorker(action: action)
        self.selecteConnectionWorker.execute()
    }
}
