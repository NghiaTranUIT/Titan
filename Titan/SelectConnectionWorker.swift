//
//  SelectionConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

struct SelectConnectionAction: Action {
    var selectedConnection: DatabaseObj
}

class SelectConnectionWorker: Worker {
    
    var action: Action!

    required init() {
        
    }
    
    func fetch() {
        
    }
}
