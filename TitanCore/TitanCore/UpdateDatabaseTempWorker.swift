//
//  UpdateDatabaseTempWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift

public struct DatabaseData {
    public var nickName: String!
    public var hostName: String!
    public var databaseName: String!
    public var username: String!
    public var password: String!
    
    public init(nickName: String?, hostName: String?, databaseName: String?, username: String?, password: String? ) {
        self.nickName = nickName ?? ""
        self.hostName = hostName ?? ""
        self.databaseName = databaseName ?? ""
        self.username = username ?? ""
        self.password = password ?? ""
    }
}

//
// MARK: - Action
struct UpdateDatabaseTempWorkerAction: Action {
    var tempData: DatabaseData
    var storeType: StoreType {return .connectionStore}
}

//
// MARK: - Worker
public struct UpdateDatabaseTempWorker: AsyncWorker {
    
    /// Type
    typealias T = DatabaseData
    public var tempData: DatabaseData!
    
    /// Execute
    func observable() -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            
            let action = UpdateDatabaseTempWorkerAction(tempData: self.tempData)
            MainStore.globalStore.dispatch(action)
            
            return Disposables.create()
        })
    }
}
