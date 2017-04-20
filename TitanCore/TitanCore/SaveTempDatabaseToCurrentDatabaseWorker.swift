//
//  SaveTempDatabaseToCurrentDatabaseWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift

//
// MARK: - Action
struct SaveTempDatabaseToCurrentDatabaseAction: Action {
    var storeType: StoreType {return .connectionStore}
}

//
// MARK: - Worker
public struct SaveTempDatabaseToCurrentDatabaseWorker: AsyncWorker {
    
    /// Type
    typealias T = Void
    
    /// Execute
    func observable() -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            
            let action = SaveTempDatabaseToCurrentDatabaseAction()
            MainStore.globalStore.dispatch(action)
            
            return Disposables.create()
        })
    }
}
