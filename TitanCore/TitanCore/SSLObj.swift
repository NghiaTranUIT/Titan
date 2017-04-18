//
//  SSLObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import ObjectMapper

open class SSLObj: BaseModel {

    //
    // MARK: - Variable
    dynamic public var clientKeyFile: String!
    dynamic public var clientCertificate: String!
    dynamic public var serverRootCertificate: String!
    dynamic public var certificateRevocationList: String!
    dynamic public var sslCompression: Bool = false
    
    //
    // MARK: - Mapping
    override public class func objectForMapping(map: Map) -> BaseMappable? {
        return SSLObj()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        self.clientKeyFile <- map[Constants.Obj.SSL.ClientKeyFile]
        self.clientCertificate <- map[Constants.Obj.SSL.ClientCertificate]
        self.serverRootCertificate <- map[Constants.Obj.SSL.ServerRootCertificate]
        self.certificateRevocationList <- map[Constants.Obj.SSL.CertificateRevocationList]
        self.sslCompression <- map[Constants.Obj.SSL.SSLCompression]
    }
}
