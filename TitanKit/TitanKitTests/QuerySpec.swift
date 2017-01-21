//
//  QuerySpec.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/20/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TitanKit

class QuerySpec: QuickSpec {
    
    override func spec() {
        
        describe("Select query") { 
            
            var database: Database!
            var connectionResult: ConnectionResult!
            
            beforeEach {
                database = Database()
                let validParam = ConnectionParam.validConnectionParam
                connectionResult = database.connectDatabase(withParam: validParam)
            }
            
            context("Select * from User", {
                it("Success", closure: {
                    
                    let connection = connectionResult.connection!
                    let query: Query = "SELECT * FROM USERS"
                    let result = connection.execute(query: query)
                    
                    // Expectation
                    expect(result.resultStatus) == ResultStatus.PGRES_TUPLES_OK
                })
            })
            
            context("Excute invalid query", { 
                it("Got error", closure: { 
                    
                    let connection = connectionResult.connection!
                    let query: Query = "SELECT123 * FROM123 USERS"
                    let result = connection.execute(query: query)
                    
                    expect(result.resultStatus).to(equal(ResultStatus.PGRES_FATAL_ERROR))
                })
            })
            
            context("Select boolean", { 
                
                it("Success", closure: { 
                    
                    let connection = connectionResult.connection!
                    let query: Query = "SELECT true"
                    let result = connection.execute(query: query)
                    
                    let row = result.rows.first
                    let field = row?["bool"]
                    
                    expect(row).notTo(beNil())
                    expect(field).notTo(beNil())
                    expect(field!.rawData).to(equal("t"))
                    expect(field!.type.rawValue).to(equal(ColumnType.boolean.rawValue))
                    expect(field!.realData as? Bool).to(beTruthy())
                })
            })
            
            context("Select a 32-bit integer", {
                it("Success", closure: { 
                    let connection = connectionResult.connection!
                    let query: Query = "SELECT 42"
                    let result = connection.execute(query: query)
                    
                    let row = result.rows.first
                    let field = row?["?column?"]
                    
                    expect(row).notTo(beNil())
                    expect(field).notTo(beNil())
                    expect(field!.realData as? Int32).to(equal(42))
                })
            })
        }
    }
}
