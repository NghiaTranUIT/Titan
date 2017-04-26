//
//  FetchTableSchemaOperation.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL

open class FetchTableSchemaOperation: BaseOperation<[Table]> {
    
    //
    // MARK: - Variable
    fileprivate var connect: Connection!
    
    //
    // MARK: - Initializer
    convenience init(connect: Connection) {
        self.init()
        self.connect = connect
    }
    
    /// Main
    override open func main() {
        super.main()
        
        // Cancel if need
        if self.checkCancelOperation() {
            return
        }
        
        // Exec
        let result = self.connect.publicTables
        self.handleSuccess(result)
    }
}
