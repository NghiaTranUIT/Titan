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
    var data: DetailConnectionData!
    
    /// Init
    init(databaseObj: DatabaseObj, data: DetailConnectionData) {
        self.databaseObj = databaseObj
        self.data = data
    }
    
    /// Execute
    func execute() -> T {
        
        // Map + Save
        RealmManager.sharedManager.writeSync {
            self.data.mapDataIntoDatabaseObj(self.databaseObj)
        }
    }
}
