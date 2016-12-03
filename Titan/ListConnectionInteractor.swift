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
    func presentError(_ error: NSError)
}


class ListConnectionInteractor {
    
    //
    // MARK: - Variable
    var output: ListConnectionInteractorOutput!
    
    
    //
    // MARK: - Worker
    fileprivate var fetchConnectionWorker: FetchAllGroupConnectionsWorker!
    fileprivate var selecteConnectionWorker: SelectConnectionWorker!
    fileprivate var addNewConnectionWorker: CreateNewDefaultConnectionWorker!
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionInteractorInput {
    
    func addNewConnection() {
        let worker = CreateNewDefaultConnectionWorker()
        
        // Execute
        worker.execute().then { db -> Void in
            // Nothing
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
        
        // Save
        self.addNewConnectionWorker = worker
    }
    
    func fetchAllGroupConnections() {
        let worker = FetchAllGroupConnectionsWorker()
        
        // Execute
        worker.execute().then { dbs -> Void in
            // Nothing
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
        
        // Save
        self.fetchConnectionWorker = worker
    }
    
    func selectConnection(_ connection: DatabaseObj) {
        self.selecteConnectionWorker = SelectConnectionWorker(selectedDb: connection)
        self.selecteConnectionWorker.execute()
    }
}
