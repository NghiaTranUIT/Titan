//
//  UserModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class UserObj: BaseModel {
    
    //
    // MARK: - Variable
    var username = "guest"
    var isGuest: Bool = true
    
    
    //
    // MARK: - Current User
    private struct Static {
        static var instance: UserObj!
    }
    
    
    /// Share instance
    class var currentUser : UserObj {
        
        // LOCK
        objc_sync_enter(self)
        defer {objc_sync_exit(self)}
        
        // Executing
        if Static.instance == nil {
            let guestUser = UserObj.guestUser()
            Static.instance = guestUser
        }
        
        return Static.instance
    }
}

//
// MARK: - Private
extension UserObj {
    
    /// Init GUEST User
    fileprivate class func guestUser() -> UserObj {
        let guestUser = UserObj()
        guestUser.isGuest = true
        return guestUser
    }
}

//
// MARK: - Realm extension
extension UserObj {
    
    /// Get all database
    func fetchAllDatabase() -> Observable<[DatabaseObj]> {
        
        if UserObj.currentUser.isGuest { // Only fetch from db
            return self.fetchAllLocalDatabase()
        }
        
        // From Cloud + local
        let local = self.fetchAllLocalDatabase()
        let cloud = self.fetchAllCloudDatabase()
        return Observable.concat([local, cloud])
    }
    
    
    /// Fetch from local database
    func fetchAllLocalDatabase() -> Observable<[DatabaseObj]> {
        return DatabaseRealmObj.fetchAll()
            .map({ (result: Results<DatabaseRealmObj>) -> [DatabaseObj] in
                var dbs: [DatabaseObj] = []
                for i in result {
                    dbs.append(i.convertToModelObj())
                }
                return dbs
            })
    }
    
    
    /// Fetch from Cloud
    func fetchAllCloudDatabase() -> Observable<[DatabaseObj]> {
        return FetchListConnectionsRequest()
            .toAlamofireObservable()
            .map({ (result) -> [DatabaseObj] in
                switch result {
                case .Failure(_):
                    return []
                case .Success(let databases):
                    return databases
            }
        })
    }
    
    
    
}
