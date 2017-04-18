
//
//  FetchConnectionWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import RealmSwift

//
// MARK: - Action
struct FetchAllGroupConnectionsAction: Action {
    var storeType: StoreType {return StoreType.connectionStore}
}

//
// MARK: - Worker
class FetchAllGroupConnectionsWorker: AsyncWorker {
    
    /// Type
    typealias T = List<GroupConnectionObj>
    
    /// Execute
    func observable() -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            
            // Fetch current User
            let currentUser = UserObj.currentUser
            let groups = currentUser.groupConnections
            
            // Dispatch
            let action = FetchAllGroupConnectionsAction()
            MainStore.globalStore.dispatch(action)
            
            observer.onNext(groups)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
}

