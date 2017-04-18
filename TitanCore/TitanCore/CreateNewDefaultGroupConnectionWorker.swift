//
//  CreateNewDefaultGroupConnectionWorker.swift
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
struct AddNewDefaultConnectionAction: Action {
    var groupConnectionObj: GroupConnectionObj
    var storeType: StoreType {return .connectionStore}
}

//
// MARK: - Worker
class CreateNewDefaultGroupConnectionWorker: AsyncWorker {
    
    /// Type
    typealias T = GroupConnectionObj
    
    /// Execute
    func observable() -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            
            // Create new default froup
            let group = GroupConnectionObj.defaultGroupConnection()
            
            // Dispatch action
            let action = AddNewDefaultConnectionAction(groupConnectionObj: group)
            MainStore.globalStore.dispatch(action)
            
            // Success
            observer.onNext(group)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
