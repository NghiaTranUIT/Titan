//
//  UpdateUIOperation.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

typealias ResponseBlock = (Any?, NSError?) -> ()

class UpdateUIOperation: BaseOperation {

    //
    // MARK: - Variable
    fileprivate var updateUIBlock: ResponseBlock?
    
    
    //
    // MARK: - Initializer
    convenience init(updateBlock : @escaping ResponseBlock) {
        self.init()
        self.updateUIBlock = updateBlock
    }
    
    override var isAsynchronous: Bool {
        return false
    }
    
    override func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Get data
        if let op = self.dependencies.first as? BaseOperation {
            self.response = op.response
            self.error = op.error
        }
        
        if let updateBlock = self.updateUIBlock {
            updateBlock(self.response, self.error)
        }
        
        self.finishOperation()
    }
}
