//
//  ConnectPostgreOperation.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/18/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL

open class ConnectPostgreOperation: BaseOperation<ConnectionResult> {
    
    //
    // MARK: - Variable
    fileprivate var param: ConnectionParam!
    fileprivate var database: Database!
    
    /// Init
    convenience init(param: ConnectionParam, database: Database) {
        self.init()
        self.param = param
        self.database = database
    }
    
    /// Main
    override open func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Exec
        let result = self.database.connectDatabase(withParam: self.param)
        self.handleSuccess(result)
    }
}
