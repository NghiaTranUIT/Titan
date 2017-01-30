//
//  Object+Lock.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

//
// MARK: - Lock
// Warp objc_sync_enter/lock into block
// We can use it anywhere in app
func synchronized(_ lock: Any, block: ()->()) {
    objc_sync_enter(lock)
    defer {
        objc_sync_exit(lock)
    }
    
    // Execute
    block()
}
