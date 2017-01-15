//
//  ListConnectionInteractor.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import PromiseKit


protocol ListConnectionInteractorOutput {
    func presentError(_ error: NSError)
}


//
// MARK: - ListConnectionInteractor
class ListConnectionInteractor {
    
    //
    // MARK: - Variable
    var output: ListConnectionInteractorOutput!
    
    
    //
    // MARK: - Worker
    fileprivate var fetchConnectionWorker: FetchAllGroupConnectionsWorker!
    fileprivate var selecteConnectionWorker: SelectConnectionWorker!
    fileprivate var createNewGroupConnectionWorker: CreateNewDefaultGroupConnectionWorker!
    fileprivate var createNewDatabaseWorker: CreateNewDatabaseWorker!
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionsControllerOutput {
    
    func addNewConnection() {
        
        // Worker
        let worker = CreateNewDefaultGroupConnectionWorker()
        
        // Execute
        worker.execute().then { group -> Void in
            // Nothing
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
        
        // Save
        self.createNewGroupConnectionWorker = worker
    }
    
    func fetchAllConnections() {
        let worker = FetchAllGroupConnectionsWorker()
        
        // Execute
        worker.execute().then { groups -> Void in
            
            
            // Check if there is no connection
            // Create new one
            // Focus too
            if groups.count == 0 {
                let worker = CreateNewDefaultGroupConnectionWorker()
                worker.execute().then(execute: { group -> Promise<DatabaseObj> in
                    let worker = CreateNewDatabaseWorker(groupConnectionObj: group)
                    return worker.execute()
                }).catch(execute: {[unowned self] error in
                    self.output.presentError(error as NSError)
                })
            }
            else if groups.count > 0 || groups.first!.databases.count == 0 {
                let worker = CreateNewDatabaseWorker(groupConnectionObj: groups.first!)
                worker.execute().then(execute: { (_) -> Void in
                    
                }).catch(execute: { (_) in
                    
                })
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
