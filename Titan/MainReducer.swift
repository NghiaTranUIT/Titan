//
//  MainReducer.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

struct MainReducer {
    
}

// MARK -
// MARK: Reducer Protocol
extension MainReducer: Reducer {
    func handleAction(action: Action, state: MainAppState?) -> MainAppState {
        return MainAppState(connectionState: ConnectionState.reducer(action: action, state: state?.connectionState))
    }
}
