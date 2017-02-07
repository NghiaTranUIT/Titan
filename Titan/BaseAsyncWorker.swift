//
//  BaseAsyncWorker.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import PromiseKit

class BaseAsyncWorker: AsyncWorker {
    
    typealias T = Void
    
    func execute() -> Promise<T> {
        return Promise(resolvers: { (fullfill, reject) in
            return fullfill()
        })
    }
}
