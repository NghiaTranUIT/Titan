//
//  DetailConnectionData.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

struct DetailConnectionData {
    
    //
    // MARK: - Variable
    var nickname: String!
    var host: String!
    var username: String!
    var password: String!
    var saveToKeyChain: Bool!
    
    // SSH
    var sshObj: SSHObj?
    
    //
    // MARK: - Public
    func mapDataIntoDatabaseObj(_ databaseObj: DatabaseObj) {
        databaseObj.name = self.nickname
        databaseObj.host = self.host
        databaseObj.username = self.username
        databaseObj.password = self.password
        databaseObj.saveToKeychain = self.saveToKeyChain
        databaseObj.ssh = self.sshObj
    }
}
