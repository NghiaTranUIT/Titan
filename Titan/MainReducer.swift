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
        let connectionState = ConnectionState.reducer(action: action, state: state?.connectionState)
        let mainTabState = MainTabState.reducer(action: action, state: state?.mainTabState)
        let detailTabState = DetailTabState.reducer(action: action, state: state?.detailTabState)
        return MainAppState(connectionState: connectionState,
                            mainTabState: mainTabState,
                            detailTabState: detailTabState)
    }
}
