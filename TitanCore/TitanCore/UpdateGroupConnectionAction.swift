//
//  UpdateGroupConnectionAction.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RealmSwift

public struct UpdateGroupConnectionAction: Action {
    
    // Storey type
    public var storeType: StoreType {
        return .connectionStore
    }
    
    // Group connection
    var groupConnection: List<GroupConnectionObj>!
}
