//
//  GroupColorRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

//
// MARK: - GroupColorRealmObj
final class GroupColorRealmObj: BaseRealmObj {
    
    
    //
    // MARK: - Variable
    var colorHex: String!
    
    
    //
    // MARK: - Public
    override func convertToModelObj() -> BaseModel {
        let color = NSColor(hexString: self.colorHex)
        return GroupColorObj(color: color)
    }
}
