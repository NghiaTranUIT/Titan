//
//  GroupColorRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

final class GroupColorRealmObj: Object {
    
    
    //
    // MARK: - Variable
    var color: NSColor!
    
    
    //
    // MARK: - Public
    func convertToModelObj() -> GroupColorObj {
        return GroupColorObj(color: self.color)
    }
}
