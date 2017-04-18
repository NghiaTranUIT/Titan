//
//  GroupColorObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper

//
// MARK: - GroupColorObj
open class GroupColorObj: BaseModel {
    
    //
    // MARK: - Variable
    dynamic public var color: String!
    
    //
    // MARK: - Init
    convenience init(color: String) {
        self.init()
        self.color = color
    }

    //
    // MARK: - Default
    static let defaultColors: [GroupColorObj] = [GroupColorObj(color: "#2ECC71"),
                                                 GroupColorObj(color: "#00B0D9"),
                                                 GroupColorObj(color: "#EE5B5B"),
                                                 ]
    
    static let defaultColor = GroupColorObj.defaultColors.first!
}
