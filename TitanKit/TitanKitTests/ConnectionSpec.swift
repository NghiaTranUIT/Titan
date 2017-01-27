//
//  Connections.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TitanKit

class ConnectionSpec: QuickSpec {
    
    override func spec() {
        
        var database: Database!
        var connectionResult: ConnectionResult!
        
        beforeEach {
            database = Database()
            let validParam = ConnectionParam.validConnectionParam
            connectionResult = database.connectDatabase(withParam: validParam)
        }
        
        describe("Fetch all database infomation") {
            context("Fetch all public table", {
                it("Success", closure: {
                    
                    let connection = connectionResult.connection!
                    let tables = connection.publicTables
                    
                    // Expectation
                    expect(tables.count) > 0
                })
            })
        }
        
        describe("Get User table") { 
            context("Get User Table", { 
                it("Success", closure: {
                    
                    let connection = connectionResult.connection!
                    let tables = connection.publicTables
                    let userTable = tables.filter({ (table) -> Bool in
                        return table.tableName == "users"
                    }).first
                    
                    // Expectation
                    expect(tables.count) > 0
                    expect(userTable).notTo(beNil())
                    expect(userTable!.isInsertableInto).to(equal(true))
                    expect(userTable!.tableName).to(equal("users"))
                })
            })
        }
    }
}
