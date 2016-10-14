//
//  UpdateUIOperation.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class UpdateUIOperation: BaseOperation {
    
    //
    // MARK: - Variable
    private var block:ResponseBlock?
    
    //
    // MARK: - Method
    convenience init(block : ResponseBlock?) {
        self.init()
        self.block = block
    }
    
    override func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Get data
        if let op = self.dependencies.first as? BaseOperation {
            self.result = op.result
        }
        
        if let block = self.block {
            block(self.result)
        }
        
        self.finishOperation()
    }
}
