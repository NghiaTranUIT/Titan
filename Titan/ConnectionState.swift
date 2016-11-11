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
    var selectedConnection = PublishSubject<DatabaseObj>()
}

//
// MARK: - Reducer
extension ConnectionState {
    static func reducer(action: Action, state: ConnectionState?) -> ConnectionState {
        let state = state ?? ConnectionState()
        
        switch action {
        case let action as SelectedConnectionAction:
            state.selectedConnection.on(.next(action.selectedConnection))
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
