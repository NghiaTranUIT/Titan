//
//  GroupColorObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper
import DynamicColor

//
// MARK: - GroupColorObj
class GroupColorObj: BaseModel {
    
    //
    // MARK: - Variable
    dynamic var color: NSColor!
    
    //
    // MARK: - Init
    convenience init(color: NSColor) {
        self.init()
        self.color = color
    }

    //
    // MARK: - Default
    static let defaultColors: [GroupColorObj] = [GroupColorObj(color: NSColor(hexString: "#2ECC71")),
                                                 GroupColorObj(color: NSColor(hexString: "#00B0D9")),
                                                 GroupColorObj(color: NSColor(hexString: "#EE5B5B")),
                                                 ]
    
    static let defaultColor = GroupColorObj.defaultColors.first!
}
