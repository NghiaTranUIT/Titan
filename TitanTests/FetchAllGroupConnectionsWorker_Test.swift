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
import RealmSwift
import ReSwift

@testable import Titan

class FetchAllGroupConnectionsWorker_Test: QuickSpec {
    
    override func spec() {
        
        var realmManager: RealmManager!
        var state = mainStore
        
        beforeEach {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Realm-testing"
            let realm = try! Realm()
            realmManager = RealmManager(realm: realm)
        }

        describe("Create realm memory - Dependency injection") {
            it("success", closure: { 
                expect(realmManager).notTo(beNil())
            })
        }
        
        describe("Store disaptch action") {
            it("FetchAllGroupConnectionsAction is disaptched", closure: {
                
                let worker = FetchAllGroupConnectionsWorker()
                worker
                .execute()
                .then(execute: { _ -> Void in
                    
                })
                .catch(execute: { _ in
                    
                })
            })
        }
    }
}
