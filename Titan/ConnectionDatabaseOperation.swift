//
//  ConnectionDatabaseOperation.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import TitanKit

class ConnectionDatabaseOperation: BaseOperation {
    
    //
    // MARK: - Variable
    var param: ConnectionParam!
    var database: Database!
    
    convenience init(param: ConnectionParam, database: Database) {
        self.init()
        self.param = param
        self.database = database
    }
    
    override func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Exec
        let result = self.database.connectDatabase(withParam: self.param)
        self._responeSuccess(result)
    }
}
