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

        let worker = CreateNewDefaultGroupConnectionWorker()
        worker.execute()
        .then(on: DispatchQueue.main) { _ -> Void in
            
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
    }
    
    func fetchAllConnections() {
        
        let worker = FetchAllGroupConnectionsWorker()
        worker.execute()
        .thenOnMainThread { groups -> Void in
            
            // Create default
            if groups.count == 0 {
                self.createDefaultGroupDatabase()
                return
            }
            
            // Have Group, but no database
            if groups.count > 0 || groups.first!.databases.count == 0 {
                self.createNewDatabase(with: groups.first!)
                return
            }
        }
        .catch { error in
            self.output.presentError(error as NSError)
        }
    }
    
    func selectConnection(_ connection: DatabaseObj) {
        let worker = SelectConnectionWorker(selectedDb: connection)
        worker.execute()
    }
}

//
// MARK: - Private
extension ListConnectionInteractor {
    
    fileprivate func createDefaultGroupDatabase() {
        
        let worker = CreateNewDefaultGroupConnectionWorker()
        worker.execute()
        .thenOnMainTheard(execute: { group -> Promise<DatabaseObj> in
            return CreateNewDatabaseWorker(groupConnectionObj: group).execute()
        })
        .then(on: DispatchQueue.main, execute: { (databaseObj) -> Void in
            
        })
        .catch(execute: {[unowned self] error in
            self.output.presentError(error as NSError)
        })
    }
    
    fileprivate func createNewDatabase(with groupObj: GroupConnectionObj) {
        
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        worker.execute().then(execute: { _ -> Void in
            
        }).catch(execute: { (_) in
            
        })
    }
}
