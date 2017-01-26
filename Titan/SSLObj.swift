//
//  SSLObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import ObjectMapper

class SSLObj: BaseModel {

    //
    // MARK: - Variable
    dynamic var clientKeyFile: String!
    dynamic var clientCertificate: String!
    dynamic var serverRootCertificate: String!
    dynamic var certificateRevocationList: String!
    dynamic var sslCompression: Bool = false
    
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
}
