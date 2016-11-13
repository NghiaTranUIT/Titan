//
//  ConnectionState.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift

struct ConnectionState {
    
    /// Connection selected
    var connections = Variable<[DatabaseObj]>([])
    var selectedConnection = PublishSubject<DatabaseObj>()
}

//
// MARK: - Reducer
extension ConnectionState {
    static func reducer(action: Action, state: ConnectionState?) -> ConnectionState {
        let state = state ?? ConnectionState()
        let disposeBag = DisposeBag()
        
        switch action {
        case let action as SelectedConnectionAction:
            state.selectedConnection.on(.next(action.selectedConnection))
            break
        case let action as AddNewConnectionToListConnectionAction:
            var currentConnections = state.connections.value
            currentConnections.append(action.newConnection)
            state.connections.value = currentConnections
            break
        case _ as GetAllConnectionsAction:
            DatabaseObj.fetchAll()
                .asDriver(onErrorJustReturn: [])
                .drive(state.connections)
                .addDisposableTo(disposeBag)
            break
        default:
            break
        }
        
        return state
    }
}


//
// MARK: - Action
struct SelectedConnectionAction: Action {
    var selectedConnection: DatabaseObj
}

struct AddNewConnectionToListConnectionAction: Action {
    var newConnection: DatabaseObj
}

struct GetAllConnectionsAction: Action {
    
}
