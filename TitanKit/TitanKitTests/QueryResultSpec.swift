//
//  QueryResultSpec.swift
//  TitanKit
//
//  Created by Nghia Tran on 2/6/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import TitanKit

class QueryResultSpec: QuickSpec {

    override func spec() {
        
        var database: Database!
        var connectionResult: ConnectionResult!
        var validParam: ConnectionParam!
        var connection: Connection!
        
        beforeEach {
            database = Database()
            validParam =  ConnectionParam.validConnectionParam
            connectionResult = database.connectDatabase(withParam: validParam)
            connection = connectionResult.connection!
        }
        
        describe("Run QUERY: SELECT id, first_name, last_name, email FROM users ORDER BY id DESC LIMIT 10") {
            
            let query: Query = "SELECT id, first_name, last_name, email FROM users ORDER BY id DESC LIMIT 10"
            
            context("Get basic data", {
                
                it("Correct", closure: {
                    let result = connection.execute(query: query)
                    
                    expect(result.resultStatus) == ResultStatus.PGRES_TUPLES_OK
                    expect(result.numberOfColumns) == 4
                    expect(result.numberOfRows) == 10
                    expect(result.rowsAffected) == 10
                })
            })
            
            context("Row value", {
                it("Correct data", closure: { 
                    
                    let result = connection.execute(query: query)
                    
                    let rows = result.rows
                    let firstRow = rows.first
                    
                    expect(firstRow).notTo(beNil())
                    
                    // Id
                    let field_id = firstRow!.field(with: "id")
                    expect(field_id).notTo(beNil())
                    expect(field_id!.rawData) == "32831"
                    expect(field_id!.isNull) == false
                    expect(field_id!.realData as? Int32) == 32831
                    
                    // Fistname
                    let field_firstName = firstRow!.field(with: "first_name")
                    expect(field_firstName).notTo(beNil())
                    expect(field_firstName!.rawData) == "NULL"
                    expect(field_firstName!.isNull) == true
                    expect(field_firstName!.realData as? NSNull).notTo(beNil())
                })
            })
            
            
        }
    }
}
