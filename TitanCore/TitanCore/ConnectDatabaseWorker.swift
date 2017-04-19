//
//  ConnectDatabaseWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift

//
// MARK: - Action
struct ConnectDatabaseAction: Action {
    var selectedDatabase: DatabaseObj!
    var storeType: StoreType {return .detailDatabaseStore}
}

//
// MARK: - Worker
public struct ConnectDatabaseWorker: AsyncWorker {
    
    /// Type
    typealias T = Void
    var databaseObj: DatabaseObj!
    
    //
    // MARK: - Init
    init(databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
    }
    
    func observable() -> Observable<T> {
        
        return PostgreSQLManager.shared.openConnection(with: self.databaseObj)
        .map({ _ -> Void in
            
            // Dispatch action
            let action = ConnectDatabaseAction(selectedDatabase: self.databaseObj)
            MainStore.dispatch(action)
            
            return
        })
    }
}

