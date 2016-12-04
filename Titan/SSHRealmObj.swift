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
    dynamic var host: String!
    dynamic var user: String!
    dynamic var indentityFile: String!
    var port: Int = 22
    
}
