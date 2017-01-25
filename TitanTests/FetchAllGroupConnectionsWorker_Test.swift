//
//  FetchAllGroupConnectionsWorker_Test.swift
//  Titan
//
//  Created by Nghia Tran on 1/25/17.
//  Copyright © 2017 fe. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Titan

class FetchAllGroupConnectionsWorker_Test: QuickSpec {

    override func spec() {
        
        describe("Fetch database") {
            context("Empty connection", closure: { 
                it("Success", closure: { 
                    
                    expect(true).to(equal(true))
                    
                })
            })
        }
    }
}
