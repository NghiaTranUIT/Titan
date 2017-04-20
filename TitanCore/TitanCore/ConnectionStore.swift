//
//  ConnectionStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import RxSwift

//
// MARK: - ConnectionStore
open class ConnectionStore: ReduxStore {
    
    //
    // MARK: - Variable
    public var groupConnections = Variable<List<GroupConnectionObj>>(List<GroupConnectionObj>())
    public var selectedDatabase = Variable<DatabaseObj?>(nil)
    public var tempDatabaseData: DatabaseData?
    
    // Story type
    public var storyType: StoreType {
        return .connectionStore
    }
    
    //
    // MARK: - Disaptch
    public func handleAction(_ action: Action) {
        
        switch action {
            
        case let action as UpdateGroupConnectionAction:
            self.groupConnections.value = action.groupConnection
            
        case _ as FetchAllGroupConnectionsAction:
            
            // Get from current User
            self.groupConnections.value = UserObj.currentUser.groupConnections
        
        case let action as SelectConnectionAction:
            
            // Save before switch
            self.saveTempDatabaseToCurrentDatabaseAction()
            
            // Get
            self.selectedDatabase.value = action.selectedConnection
            
        case let action as UpdateDatabaseTempWorkerAction:
            self.tempDatabaseData = action.tempData
        
        case _ as SaveTempDatabaseToCurrentDatabaseAction:
            self.saveTempDatabaseToCurrentDatabaseAction()
            
        case let action as CreateNewDatabaseAction:
            
            let group = self.groupConnections
            let selectedGroup = action.groupConnectionObj!
            let newDatabaseObj = action.databaseObj!
            
            // Fitler
            let groups = group.value.filter({ (obj) -> Bool in
                return selectedGroup.objectId == obj.objectId
            })
            
            // Add
            if let group = groups.first {
                RealmManager.sharedManager.writeSync { _ in
                    group.databases.append(newDatabaseObj)
                }
            }
            
        case let action as AddNewDefaultConnectionAction:
            let group = self.groupConnections.value
            
            // Save
            RealmManager.sharedManager.writeSync { _ in
                group.append(action.groupConnectionObj)
            }
            
        default:
            
            // Do nothing
            assert(true, "Fotgo new action = \(action)")
            break
        }
    }
}

//
// MARK: - Private
extension ConnectionStore {
    
    fileprivate func saveTempDatabaseToCurrentDatabaseAction() {
        
        guard let databaseObj = self.selectedDatabase.value else {return}
        guard let temp = self.tempDatabaseData else {return}
        
        Logger.info("Save data = \(temp)")
        
        RealmManager.sharedManager.writeSync { _ in
            databaseObj.name = temp.nickName
            databaseObj.database = temp.databaseName
            databaseObj.username = temp.username
            databaseObj.password = temp.password
            databaseObj.host = temp.hostName
        }
    }
}
