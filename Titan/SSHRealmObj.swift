//
//  SSHRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/9/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift


//
// MARK: - SSHRealmObj
class SSHRealmObj: BaseRealmObj {

    
    //
    // MARK: - Variable
    var host: String!
    var user: String!
    var indentityFile: String!
    var port: Int!
    
}
