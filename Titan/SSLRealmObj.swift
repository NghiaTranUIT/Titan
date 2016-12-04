//
//  SSLRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/9/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift


//
// MARK: - SSLRealmObj
class SSLRealmObj: BaseRealmObj {

    
    //
    // MARK: - Variable
    dynamic var clientKeyFile: String!
    dynamic var clientCertificate: String!
    dynamic var serverRootCertificate: String!
    dynamic var certificateRevocationList: String!
    dynamic var sslCompression = false
    
}
