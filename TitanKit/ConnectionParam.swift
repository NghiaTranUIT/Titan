//
//  ConnectionParam.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation

public struct ConnectionParam {
    
    //
    // MARK: - Variable
    public let host: String
    public let port: String
    public let options: String
    public let databaseName: String
    public let user: String
    public let password: String
    
    public init(host: String, port: String, options: String, databaseName: String, user: String, password: String) {
        self.host = host
        self.port = port
        self.options = options
        self.databaseName = databaseName
        self.user = user
        self.password = password
    }
}
