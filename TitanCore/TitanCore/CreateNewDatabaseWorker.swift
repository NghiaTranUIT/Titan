//
//  CreateNewDatabaseWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

//
// MARK: - Action
struct CreateNewDatabaseAction: Action {
    var databaseObj: DatabaseObj!
    var groupConnectionObj: GroupConnectionObj!
    var storeType: StoreType {return .connectionStore}
}

//
// MARK: - Worker
class CreateNewDatabaseWorker: AsyncWorker {
    
    /// Type
    typealias T = DatabaseObj
    var groupConnectionObj: GroupConnectionObj!
    
    /// Init
    init(groupConnectionObj: GroupConnectionObj) {
        self.groupConnectionObj = groupConnectionObj
    }
    
    /// Execute
    func observable() -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            
            // Create default db
            let defaultDb = DatabaseObj.defaultDatabase()
            
            // Action
            let action = CreateNewDatabaseAction(databaseObj: defaultDb, groupConnectionObj: self.groupConnectionObj)
            MainStore.globalStore.dispatch(action)
            
            // Success
            observer.onNext(defaultDb)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
