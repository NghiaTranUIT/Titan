//
//  ParamConnection+Helper.swift
//  TitanKit
//
//  Created by Nghia Tran on 11/15/16.
//  Copyright © 2016 Titan. All rights reserved.
//

import Foundation
import TitanKit

extension ConnectionParam {
    
    
    /// Valid
    static var validConnectionParam: ConnectionParam {
        get {
            return ConnectionParam(host: "localhost", port: "5432", options: "", databaseName: "pixai_dashboard_development", user: "feels", password: "feels536")
        }
    }
    
    
    /// Invalid
    static var invalidConnectionParam: ConnectionParam {
        get {
            return ConnectionParam(host: "localhost", port: "5432", options: "", databaseName: "pixai_dashboard_development", user: "feels", password: "feels536")
        }
    }
}
