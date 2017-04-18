//
//  SelectConnectionWorker.swift
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
struct SelectConnectionAction: Action {
    var selectedConnection: DatabaseObj
    var storeType: StoreType {return .connectionStore}
}

//
// MARK: - Worker
public struct SelectConnectionWorker: AsyncWorker {
    
    /// Type
    typealias T = DatabaseObj
    public var selectedDb: DatabaseObj!
    
    /// Execute
    func observable() -> Observable<DatabaseObj> {
        return Observable.create({ (observer) -> Disposable in
            
            let action = SelectConnectionAction(selectedConnection: self.selectedDb)
            MainStore.globalStore.dispatch(action)
            
            return Disposables.create()
        })
    }
}
