//
//  ConnectionState.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

struct ConnectionState {
    
}

//
// MARK: - Reducer
extension ConnectionState {
    static func reducer(action: Action, state: ConnectionState?) -> ConnectionState {
        let state = state ?? ConnectionState()
        
        switch action {
        case _ as GetListConnectionRequest:
            break
        case _ as GetConnectionFromDatabaseAction:
            break
        default:
            break
        }
        
        return state
    }
}

//
// MARK: - Action
struct GetConnectionFromDatabaseAction: Action {
    
}
