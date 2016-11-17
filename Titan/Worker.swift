//
//  Worker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift


//
// MARK: - Worker
protocol Worker {
    
    var action: Action! {get set}
    
    init()
}


extension Worker {
    
    init(action: Action) {
        self.init()
        self.action = action
    }
}
