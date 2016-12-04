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
    fileprivate var createNewGroupConnectionWorker: CreateNewDefaultGroupConnectionWorker!
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionInteractorInput {
    
    func addNewConnection() {
        
        // Worker
        let worker = CreateNewDefaultGroupConnectionWorker()
        
        // Execute
        worker.execute().then { db -> Void in
            // Nothing
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
        
        // Save
        self.createNewGroupConnectionWorker = worker
    }
    
    func fetchAllGroupConnections() {
        let worker = FetchAllGroupConnectionsWorker()
        
        // Execute
        worker.execute().then {[unowned self] groups -> Void in
            
            // Check if there is no connection
            // Create new one
            // Focus too
            if groups.count == 0 {
                //self.addNewConnection()
            }
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
