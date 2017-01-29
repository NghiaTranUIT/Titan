//
//  FetchTableSchemaInfoOperation.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import TitanKit

class FetchTableSchemaInfoOperation: BaseOperation {

    //
    // MARK: - Variable
    fileprivate var connect: Connection!
    
    //
    // MARK: - Initializer
    convenience init(connect: Connection) {
        self.init()
        self.connect = connect
    }
    
    override func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Exec
        let result = self.connect.publicTables
        self._responeSuccess(result)
    }
    
}
