//
//  SaveDatabaseObjToDisk.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import PromiseKit

class SaveDatabaseObjToDiskWorker: SyncWorker {
    
    /// Type
    typealias T = Void
    var databaseObj: DatabaseObj!
    
    /// Init
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    /// Execute
    func execute() -> T {
        
        // Save
        RealmManager.sharedManager
        .save(obj: self.databaseObj)
        .then { _ -> Void in}
        .catch { error in
            Logger.error(error)
        }
    }
}
