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
    var colorHex: String!
    
    
    //
    // MARK: - Public
    func convertToModelObj() -> GroupColorObj {
        let color = NSColor(hexString: self.colorHex)
        return GroupColorObj(color: color)
    }
}
