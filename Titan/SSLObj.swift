//
//  SSLObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper

class SSLObj: BaseModel {

    
    //
    // MARK: - Variable
    var clientKeyFile: String!
    var clientCertificate: String!
    var serverRootCertificate: String!
    var certificateRevocationList: String!
    var sslCompression: Bool!
    
    
    /// Realm Obj class
    override var realmObjClass: BaseRealmObj.Type {
        get {
            return SSLRealmObj.self
        }
        
    }
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.clientKeyFile <- map[Constants.Obj.SSL.ClientKeyFile]
        self.clientCertificate <- map[Constants.Obj.SSL.ClientCertificate]
        self.serverRootCertificate <- map[Constants.Obj.SSL.ServerRootCertificate]
        self.certificateRevocationList <- map[Constants.Obj.SSL.CertificateRevocationList]
        self.sslCompression <- map[Constants.Obj.SSL.SSLCompression]
    }
    
    
    /// Convert
    override func convertToRealmObj() -> BaseRealmObj {
        let realmObj = SSLRealmObj()
        
        realmObj.objectId = self.objectId
        realmObj.updatedAt = self.updatedAt
        realmObj.createdAt = self.createdAt
        
        realmObj.clientKeyFile = self.clientKeyFile
        realmObj.clientCertificate = self.clientCertificate
        realmObj.serverRootCertificate = self.serverRootCertificate
        realmObj.certificateRevocationList = self.certificateRevocationList
        realmObj.sslCompression = self.sslCompression
        
        return realmObj
    }
    
}
