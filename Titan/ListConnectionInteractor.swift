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
}


//
// MARK: - ListConnectionInteractorInput
extension ListConnectionInteractor: ListConnectionsControllerOutput {
    
    func addNewConnection() {
        
        // Worker
        let worker = CreateNewDefaultGroupConnectionWorker()
        
        // Execute
        worker.execute()
        .then(on: DispatchQueue.main) { _ -> Void in
            
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
    }
    
    func fetchAllConnections() {
        
    }
    
    func selectConnection(_ connection: DatabaseObj) {
        let worker = SelectConnectionWorker(selectedDb: connection)
        worker.execute()
    }
}

//
// MARK: - Private
extension ListConnectionInteractor {
    
    fileprivate func createNewGroupConnection() -> Promise<GroupConnectionObj> {
        let worker = CreateNewDefaultGroupConnectionWorker()
        return worker.execute()
    }
    
    fileprivate func createNewDatabase(with groupObj: GroupConnectionObj) -> Promise<DatabaseObj> {
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        return worker.execute()
    }
}
