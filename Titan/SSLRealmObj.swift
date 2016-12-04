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
    var clientKeyFile: String!
    var clientCertificate: String!
    var serverRootCertificate: String!
    var certificateRevocationList: String!
    var sslCompression: Bool!
    
}
