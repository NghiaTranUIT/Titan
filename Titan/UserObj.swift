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

//
// MARK: - UserObj
final class UserObj: BaseModel {
    
    
    //
    // MARK: - Variable
    var username = "guest"
    var isGuest: Bool = true
    var groupConnections: [GroupConnectionObj] = []
    
    
    /// Realm Obj class
    override var realmObjClass: BaseRealmObj.Type {
        get {
            return UserRealmObj.self
        }
    }
    
    
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
    
    
    //
    // MARK: - Override
    override func convertToRealmObj() -> BaseRealmObj {
        
        let realmObj = UserRealmObj()
        
        realmObj.objectId = self.objectId
        realmObj.createdAt = self.createdAt
        realmObj.updatedAt = self.updatedAt
        realmObj.username = self.username
        realmObj.isGuest = self.isGuest
        let groups = self.groupConnections.map({ groupObj -> GroupConnectionRealmObj in
            return groupObj.convertToRealmObj() as! GroupConnectionRealmObj
        })
        realmObj.groupConnections.append(objectsIn: groups)
        return realmObj
    }
}


//
// MARK: - Private
extension UserObj {
    
    /// Init GUEST User
    fileprivate class func guestUser() -> UserObj {
        let guestUser = UserObj()
        guestUser.objectId = "GuestUser"
        guestUser.isGuest = true
        return guestUser
    }
}

