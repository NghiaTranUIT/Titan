//
//  FetchTableSchemaWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import SwiftyPostgreSQL

struct FetchTableSchemaAction: Action {
    var tables: [Table]!
    var storeType: StoreType {return .detailDatabaseStore}
}

class FetchTableSchemaWorker: AsyncWorker {
    
    typealias T = Void
    
    func observable() -> Observable<T> {
        return PostgreSQLManager.shared
            .fetchTableSchema()
            .observeOn(MainScheduler.instance)
            .do(onNext: { tables in
                
                let action = FetchTableSchemaAction(tables: tables)
                MainStore.dispatch(action)
            })
        .map({ (_) -> Void in
            return
        })
    }
}
