//
//  MainAppState.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

struct MainAppState: StateType {
    
    //
    // MARK: - States
    
    /// Connection lis state
    let connectionState: ConnectionState?
    
    /// Main tab state
    let mainTabState: MainTabState?
    
    /// Detail Tab state
    let detailTabState: DetailTabState?
}
