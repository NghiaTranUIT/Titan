//
//  CreateNewDefaultConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/19/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import BrightFutures

struct CreateNewDefaultConnectionAction: Action {
    
}

struct AddNewDefaultConnectionAction: Action {
    var newConnection: DatabaseObj
}

class CreateNewDefaultConnectionWorker: AsyncWorker {

    typealias T = DatabaseObj
    
    var action: Action!
    
    required init() {
        
    }
    
    func execute() -> Future<T, NSError> {
        
    }
}
