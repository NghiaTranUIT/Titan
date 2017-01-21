//
//  Logger.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/20/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation


//
// MARK: - Logger
/// Internal Logger
public class Logger {
    
    /// Error
    public class func error(_ text: String, fileName: String = #file, functionName: String = #function, line: Int = #line) {
        print("[ERROR]:\(fileName):\(functionName):\(line) => \(text)")
    }
}
